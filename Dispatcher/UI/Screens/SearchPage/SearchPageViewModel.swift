//
//  SearchPageViewModel.swift
//  Dispatcher
//
//  Created by Hadar Basson on 23/08/2023.
//

import Foundation

class SearchPageViewModel {
    let maxSearchesCount = 10
    let defaults = UserDefaults.standard
    
    var recentSearches: [String] {
        get {
            return getUserSearchesForCurrentUser()
        }
    }
    
    func addUserSearchEntry(keyword: String) {
        var userSearches = getUserSearches()
        if let currentUser = defaults.string(forKey: "email") {
            var searches = userSearches[currentUser] ?? []
            if let index = searches.firstIndex(of: keyword) {
                searches.remove(at: index)
            }
            searches.insert(keyword, at: 0)
            
            if searches.count > maxSearchesCount {
                searches.removeLast()
            }
            userSearches[currentUser] = searches
            saveUserSearches(userSearches)
        }
 
    }
    
    func getUserSearches() -> [String: [String]] {
        return UserDefaults.standard.dictionary(forKey: "UserSearches") as? [String: [String]] ?? [:]
    }
    
    func saveUserSearches(_ searches: [String: [String]]) {
        UserDefaults.standard.set(searches, forKey: "UserSearches")
    }
    
    func getUserSearchesForCurrentUser() -> [String] {
        if let currentUserEmail = UserDefaults.standard.string(forKey: "email") {
            let userSearches = getUserSearches()
            return userSearches[currentUserEmail] ?? []
        } else {
            return []
        }
    }
    
    @objc func removeSearchEntry(at index: Int) {
        var userSearches = getUserSearches()
        
        if let currentUserEmail = UserDefaults.standard.string(forKey: "email") {
            var currentUserSearches = userSearches[currentUserEmail] ?? []
            
            if index < currentUserSearches.count {
                currentUserSearches.remove(at: index)
                userSearches[currentUserEmail] = currentUserSearches
                saveUserSearches(userSearches)
            }
        }
    }
    
    func clearAll() {
        var userSearches = getUserSearches()
        
        if let currentUserEmail = UserDefaults.standard.string(forKey: "email") {
            userSearches[currentUserEmail] = []
            saveUserSearches(userSearches)
        }
    }
}
