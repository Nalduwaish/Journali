//
//  Journal.swift
//  Journali
//
//  Created by Najla on 05/05/1447 AH.
//

// Models/Journal.swift
import Foundation

struct Journal: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    var date: Date
    var preview: String
    var bookmarked: Bool

    init(id: UUID = UUID(), title: String, date: Date, preview: String, bookmarked: Bool = false) {
        self.id = id
        self.title = title
        self.date = date
        self.preview = preview
        self.bookmarked = bookmarked
    }

    static let sample: [Journal] = [
        .init(title: "My Birthday", date: .now, preview: lorem, bookmarked: true),
        .init(title: "Today’s Journal", date: .now, preview: lorem),
        .init(title: "Great Day", date: .now, preview: lorem)
    ]
}

private let lorem = """
Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio.
Quisque volutpat mattis eros. Nullam malesuada erat ut turpis.
"""
