// Views/EmptyState.swift
import SwiftUI

struct EmptyState: View {
    private let purple = Color(red: 212/255, green: 200/255, blue: 255/255)
    @EnvironmentObject public var vm: JournalListViewModel

    var body: some View {
        VStack {
            HStack {
                Text("Journal").font(.largeTitle.bold())
                Spacer()
                HStack(spacing:16) {
                    Image(systemName: "line.3.horizontal.decrease")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.gray)
                        .frame(width: 36, height:36)
                    
                    Button { vm.showNewJournal = true } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.white.opacity(0.7))
                            .frame(width: 36, height: 36)
                    }
                }
                .frame(width: 104, height:48)
                .padding(.horizontal, 6)
                .padding(.vertical, 6)
                .glassEffect(.clear .interactive())
            }
            .padding(.horizontal, 20)
            .padding(.top, 12)

            ZStack {
                Color(.systemBackground).ignoresSafeArea()
                VStack(alignment: .center) {
                    Image("Book")
                        .resizable()
                        .frame(width: 151.39 , height: 97.32)
                        .padding(34.62)
                    Text("Begin Your Journal")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(purple)
                        .padding(16)
                    Text("Craft your personal diary,Tap the \nplus icon to begin")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 18, weight: .light))
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
        }
    }
}
