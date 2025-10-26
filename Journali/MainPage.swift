import SwiftUI
import AVFoundation

struct MainPage: View {
    // Accent
    private let purple = Color(red: 212/255, green: 200/255, blue: 255/255)

    @State private var search = ""
    @State private var entries: [Journal] = Journal.sample
    
    // ===== Sorting =====
    private enum SortKey { case byDateDesc, bookmarkedFirst }
    @State private var sortKey: SortKey = .byDateDesc

    private func sortByDate() {
        entries.sort { $0.date > $1.date }
        sortKey = .byDateDesc
    }

    private func sortByBookmark() {
        entries.sort {
            ($0.bookmarked ? 0 : 1, $1.date) < ($1.bookmarked ? 0 : 1, $0.date)
        }
        sortKey = .bookmarkedFirst
    }

    // ===== Delete state =====
    @State private var showDeleteConfirm = false
    @State private var pendingDeleteIndex: Int? = nil

    var body: some View {
        NavigationStack {   // 👈 wrap in NavigationStack to enable navigation
            ZStack {
              //Color.black.ignoresSafeArea()

                VStack(spacing: 0) {
                    // ===== Header =====
                    HStack {
                        Text("Journal")
                            .font(.largeTitle.weight(.bold))
                            .foregroundColor(.white)

                        Spacer()

                        HStack(spacing: 16) {
                            // SORT
                            Menu {
                                Button("Sort by Bookmark") { sortByBookmark() }
                                Button("Sort by Entry Date") { sortByDate() }
                            } label: {
                                Image(systemName: "line.3.horizontal.decrease")
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundColor(.white.opacity(0.7))
                                    .frame(width: 36, height: 36)
                            }
                            .menuIndicator(.hidden)
                            
                            // ADD → navigate to NewJournal
                            NavigationLink {
                                NewJournal { newEntry in
                                    // append to your list
                                    entries.append(newEntry)
                                    
                                    // keep current sort behavior
                                    switch sortKey {
                                    case .byDateDesc:
                                        entries.sort { $0.date > $1.date }
                                    case .bookmarkedFirst:
                                        entries.sort { ($0.bookmarked ? 0 : 1, $1.date) < ($1.bookmarked ? 0 : 1, $0.date) }
                                    }
                                }
                            } label: {
                                Image(systemName: "plus")
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundColor(.white.opacity(0.7))
                                    .frame(width: 36, height: 36)
                            }
                        }
                        
                        .frame(width: 104, height: 48)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 6)
                        .glassEffect(.clear.interactive())
                        .clipShape(Capsule())
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 12)

                    // ===== Cards (List with swipe-to-delete) =====
                    List {
                        ForEach(Array(entries.enumerated()), id: \.element.id) { index, _ in
                            JournalCard(entry: $entries[index], accent: purple)
                                .listRowInsets(EdgeInsets())
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button(role: .destructive) {
                                        pendingDeleteIndex = index
                                        showDeleteConfirm = true
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                    .tint(.red)
                                }
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .background(Color.black)
                    .padding(.horizontal, 16)
                 //   .padding(.bottom, 90) // leave space for floating search bar
                } // ← closes header+list VStack

                // ===== Floating search bar (overlays via ZStack) =====
                VStack {
                    Spacer()
                    HStack(spacing: 12) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white.opacity(0.7))
                            .font(.system(size: 17, weight: .medium))

                        TextField("Search", text: $search)
                            .foregroundColor(.white.opacity(0.9))
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled(true)
                            .tint(purple)

                        Button { /* requestMicrophonePermission() */ } label: {
                            Image(systemName: "microphone")
                                .foregroundColor(.white.opacity(0.7))
                                .font(.system(size: 17, weight: .medium))
                                .frame(width: 36, height: 36)
                        }
                    }
                    .padding(.horizontal, 12)
                    .frame(maxWidth: .infinity, minHeight: 56)
                    .background(Capsule().fill(Color.clear))
                    .clipShape(Capsule())
                    .glassEffect(.regular.interactive())
                    .padding(.horizontal, 16)
                   // .padding(.bottom, 50)
                }
            }
            // ===== Confirm delete alert =====
            .alert("Delete Journal?",
                   isPresented: $showDeleteConfirm) {
                Button("Delete", role: .destructive) {
                    if let i = pendingDeleteIndex, entries.indices.contains(i) {
                        withAnimation(.easeInOut) {
                            entries.remove(at: i)
                        }
                    }
                    pendingDeleteIndex = nil
                }
                Button("Cancel", role: .cancel) {
                    pendingDeleteIndex = nil
                }
            } message: {
                Text("Are you sure you want to delete this journal?")
            }
            .navigationBarHidden(true) // hide the default nav bar since you have a custom header
        }
    }
}

// MARK: - JournalCard
struct JournalCard: View {
    @Binding var entry: Journal
    let accent: Color

    var body: some View {
        ZStack(alignment: .topTrailing) {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color.white.opacity(0.06))
                .overlay(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .stroke(Color.white.opacity(0.06))
                )

            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .top) {
                    Text(entry.title)
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(accent)
                    Spacer(minLength: 8)
                }

                Text(entry.date.formatted(.dateTime.day().month().year()))
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.white.opacity(0.6))
                    .padding(.bottom, 4)

                Text(entry.preview)
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(.white.opacity(0.85))
                    .lineLimit(10)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.top, 8)
            }
            .padding(16)

            Button {
                entry.bookmarked.toggle()
            } label: {
                Image(systemName: entry.bookmarked ? "bookmark.fill" : "bookmark")
                    .foregroundColor(accent)
                    .font(.system(size: 18, weight: .semibold))
                    .padding(10)
            }
            .contentShape(Rectangle())
            .padding(8)
        }
        .shadow(color: .black.opacity(0.3), radius: 12, x: 0, y: 6)
        .padding(.bottom, 16) // spacing between cards
    }
}

// MARK: - NewJournal screen (you can replace this with your real one)
struct NewJounral: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            Text("New Journal Page")
                .foregroundColor(.white)
                .font(.title)
        }
        .navigationTitle("New Journal")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Model
struct Journal: Identifiable {
    let id = UUID()
    var title: String
    var date: Date
    var preview: String
    var bookmarked: Bool

    static let sample: [Journal] = [
        .init(title: "My Birthday", date: .now, preview: lorem, bookmarked: true),
        .init(title: "Today’s Journal", date: .now, preview: lorem, bookmarked: false),
        .init(title: "Great Day", date: .now, preview: lorem, bookmarked: false)
    ]
}

private let lorem = """
Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros. Nullam malesuada erat ut turpis. Suspendisse urna nibh viverra non semper suscipit posuere a pede.
"""

#Preview { MainPage() }
//#Preview { NewJournal() }
