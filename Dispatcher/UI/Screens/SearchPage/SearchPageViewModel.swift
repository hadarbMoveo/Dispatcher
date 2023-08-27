//
//  SearchPageViewModel.swift
//  Dispatcher
//
//  Created by Hadar Basson on 23/08/2023.
//

import Foundation
class SearchPageViewModel {
    
    let maxSearchesCount = 10
    
    var recentSearches: [String] {
        get {
            return UserDefaults.standard.array(forKey: "RecentSearches") as? [String] ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "RecentSearches")
        }
    }
    
    func addSearchEntry(keyword: String) {
        var searches = recentSearches
        if let index = searches.firstIndex(of: keyword) {
            searches.remove(at: index)
        }
        searches.insert(keyword, at: 0)
        if searches.count > maxSearchesCount {
            searches.removeLast()
        }
        recentSearches = searches
    }
    
    @objc func removeSearchEntry(at index: Int) {
        var searches = recentSearches
        searches.remove(at: index)
        recentSearches = searches
    }
    
    
    func clearAll() {
        recentSearches = []
    }
}
