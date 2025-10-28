//
//  JounalCard.swift
//  Journali
//
//  Created by Najla on 05/05/1447 AH.
//

// Views/JournalCard.swift
import SwiftUI

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

            Button { entry.bookmarked.toggle() } label: {
                Image(systemName: entry.bookmarked ? "bookmark.fill" : "bookmark")
                    .foregroundColor(accent)
                    .font(.system(size: 18, weight: .semibold))
                    .padding(10)
            }
            .contentShape(Rectangle())
            .padding(8)
        }
        .shadow(color: .black.opacity(0.3), radius: 12, x: 0, y: 6)
        .padding(.bottom, 16)
    }
}
