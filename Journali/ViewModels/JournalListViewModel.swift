// ViewModels/JournalListViewModel.swift
import Foundation
import Combine
import SwiftUI


@MainActor
final class JournalListViewModel: ObservableObject {
    enum SortKey { case byDateDesc, bookmarkedFirst }

    @Published var entries: [Journal] = Journal.sample
    @Published var search: String = ""
    @Published var sortKey: SortKey = .byDateDesc

    // Sheet + delete UI state (kept here to simplify views)
    @Published var showNewJournal: Bool = false
    @Published var showDeleteConfirm: Bool = false
    @Published var pendingDeleteIndex: Int?

    // MARK: - Intents
    func add(_ journal: Journal) {
        entries.append(journal)
        applyCurrentSort()
    }

    func removePending() {
        if let i = pendingDeleteIndex, entries.indices.contains(i) {
            entries.remove(at: i)
        }
        pendingDeleteIndex = nil
    }

    func sortByDate() {
        sortKey = .byDateDesc
        entries.sort { $0.date > $1.date }
    }

    func sortByBookmark() {
        sortKey = .bookmarkedFirst
        entries.sort {
            ($0.bookmarked ? 0 : 1, $0.date) < ($1.bookmarked ? 0 : 1, $1.date)
        }
    }

    func applyCurrentSort() {
        switch sortKey {
        case .byDateDesc:    sortByDate()
        case .bookmarkedFirst: sortByBookmark()
        }
    }

    // Optional: search filtering (simple—for live filtering in the View)
    func filteredEntries() -> [Journal] {
        let q = search.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !q.isEmpty else { return entries }
        return entries.filter {
            $0.title.lowercased().contains(q) || $0.preview.lowercased().contains(q)
        }
    }
 

}

