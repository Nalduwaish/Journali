// Views/MainPage.swift
import SwiftUI

struct MainPage: View {
    @EnvironmentObject public var vm: JournalListViewModel
    private let purple = Color(red: 212/255, green: 200/255, blue: 255/255)

    var body: some View {
        NavigationStack {
            Group {
                if vm.entries.isEmpty {
                    EmptyState()
                        .transition(.opacity)
                } else {
                    ZStack {
                        VStack(spacing: 16) {
                            // Header
                            HStack {
                                Text("Journal")
                                    .font(.largeTitle.weight(.bold))
                                    .foregroundColor(.white)
                                Spacer()
                                HStack(spacing: 16) {
                                    Menu {
                                        Button("Sort by Bookmark") { vm.sortByBookmark() }
                                        Button("Sort by Entry Date") { vm.sortByDate() }
                                    } label: {
                                        Image(systemName: "line.3.horizontal.decrease")
                                            .font(.system(size: 20, weight: .medium))
                                            .foregroundColor(.white.opacity(0.7))
                                            .frame(width: 36, height: 36)
                                    }
                                    .menuIndicator(.hidden)

                                    Button { vm.showNewJournal = true } label: {
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

                            // List with swipe-to-delete
                            List {
                                ForEach(Array(vm.filteredEntries().enumerated()), id: \.element.id) { index, item in
                                    // Map filtered item back to original index
                                    if let realIndex = vm.entries.firstIndex(of: item) {
                                        JournalCard(entry: $vm.entries[realIndex], accent: purple)
                                            .listRowInsets(EdgeInsets())
                                            .listRowSeparator(.hidden)
                                            .listRowBackground(Color.clear)
                                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                                Button(role: .destructive) {
                                                    vm.pendingDeleteIndex = realIndex
                                                    vm.showDeleteConfirm = true
                                                } label: {
                                                    Label("Delete", systemImage: "trash")
                                                }
                                                .tint(.red)
                                            }
                                    }
                                }
                            }
                            .listStyle(.plain)
                            .scrollContentBackground(.hidden)
                            .background(Color.black)
                            .padding(.horizontal, 16)
                        }

                        // Floating search bar
                        VStack {
                            Spacer()
                            HStack(spacing: 12) {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.white.opacity(0.7))
                                    .font(.system(size: 17, weight: .medium))
                                TextField("Search", text: $vm.search)
                                    .foregroundColor(.white.opacity(0.9))
                                    .textInputAutocapitalization(.never)
                                    .autocorrectionDisabled(true)
                                    .tint(purple)
                                Button {} label: {
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
                        }
                    }
                }
            }
            .sheet(isPresented: $vm.showNewJournal) {
                NewJournal { newEntry in
                    vm.add(newEntry)
                }
                .presentationDetents([.large])
                .presentationCornerRadius(30)
            }
            .alert("Delete Journal?", isPresented: $vm.showDeleteConfirm) {
                Button("Delete", role: .destructive) { vm.removePending() }
                Button("Cancel", role: .cancel) { vm.pendingDeleteIndex = nil }
            } message: {
                Text("Are you sure you want to delete this journal?")
            }
            .navigationBarHidden(true)
        }
    }
}
#Preview {
    MainPage()
        .environmentObject(JournalListViewModel()) // ✅ inject dummy VM for preview
}
