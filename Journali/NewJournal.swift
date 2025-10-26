import SwiftUI

struct NewJournal: View {
    private let purple = Color(red: 127/255, green: 129/255, blue: 255/255)

    @Environment(\.dismiss) private var dismiss

    @State private var titleText = ""
    @State private var bodyText  = ""
    @State private var showDiscard = false

    // 👇 Callback to send the created entry back to MainPage
    var onSave: (Journal) -> Void = { _ in }

    var body: some View {
        ZStack(alignment: .top) {
            // ===== Background
            ContainerRelativeShape()
                .fill(Color(red: 28/255, green: 28/255, blue: 30/255))
                .frame(width: 392.82, height: 793.46)
               // .ignoresSafeArea()

            Capsule()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 40, height: 5)
              //  .ignoresSafeArea()
                .padding(.top, 12)

            // ===== Top bar
            VStack(spacing: 0) {
                HStack {
                    // X (left) -> trigger discard dialog
                    Button { showDiscard = true } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                    }
                    .glassEffect(.clear.interactive())

                    Spacer()

                    // Checkmark (right) -> save entry and dismiss
                    Button {
                        let newEntry = Journal(
                            title: titleText.isEmpty ? "Untitled" : titleText,
                            date: .now,
                            preview: bodyText,
                            bookmarked: false
                        )
                        onSave(newEntry)   // ✅ send to MainPage
                        dismiss()          // ✅ go back
                    } label: {
                        Image(systemName: "checkmark")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.black)
                            .frame(width: 44, height: 44)
                    }
                    .glassEffect(.clear .tint(purple).interactive())
                }
                .padding(.horizontal, 24)
                .padding(.top, 30)

                // ===== Editor content
                VStack(alignment: .leading, spacing: 12)  {
                    TextField("Title", text: $titleText)
                        .font(Font.largeTitle.bold())
                        .foregroundColor(Color.white)
                        .tint(purple)

                    Text(Date.now.formatted(.dateTime.day().month().year()))
                        .padding(.bottom, 10)
                        .font(.title3)
                        .foregroundColor(Color.gray)

                    TextField("Type your Journal…", text: $bodyText, axis: .vertical)
                        .font(.title.weight(.regular))
                        .foregroundColor(Color.white)
                        .padding(.top, 26)
                        .tint(purple)
                        
                    
                }
                .padding(.leading)
                .padding(.top, 24)

                Spacer(minLength: 24)
            }

            // ===== Confirm Discard Dialog (overlay)
            if showDiscard {
                Color.black.opacity(0.35)
                    .ignoresSafeArea()
                    .onTapGesture { withAnimation { showDiscard = false } }

                VStack(spacing: 40) {
                    Text("Are you sure you want to discard changes on this journal?")
                        .font(.headline)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.white.opacity(0.9))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        .fixedSize(horizontal: false, vertical: true)

                    VStack(spacing: 10) {
                        // Destructive
                        Button {
                            // clear and go back
                            titleText = ""
                            bodyText  = ""
                            withAnimation { showDiscard = false }
                            dismiss()                      // ✅ pop back to MainPage
                        } label: {
                            Text("Discard Changes")
                                .font(.headline)
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(
                                    Capsule()
                                        .fill(.ultraThinMaterial)
                                        .overlay(Capsule().stroke(Color.white.opacity(0.10)))
                                        .glassEffect(.clear.interactive())
                                )
                        }

                        // Cancel
                        Button {
                            withAnimation { showDiscard = false }
                        } label: {
                            Text("Keep Editing")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(
                                    Capsule()
                                        .fill(.ultraThinMaterial)
                                        .overlay(Capsule().stroke(Color.black.opacity(0.08)))
                                        .glassEffect(.clear.interactive())
                                )
                        }
                    }
                    .padding(.horizontal, 14)
                    .padding(.bottom, 14)
                }
                .frame(width: 300, height: 212)
                .background(
                    RoundedRectangle(cornerRadius: 28, style: .continuous)
                        .glassEffect(.clear, in: .rect(cornerRadius: 28))
                )
                .padding(.horizontal, 50)
                .transition(.scale(scale: 0.96).combined(with: .opacity))
                .zIndex(1)
                .multilineTextAlignment(.leading)
            }
        }
        .animation(.spring(response: 0.35, dampingFraction: 0.9), value: showDiscard)
    }
}

#Preview { NewJournal() }
