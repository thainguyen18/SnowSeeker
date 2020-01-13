//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Thai Nguyen on 1/12/20.
//  Copyright © 2020 Thai Nguyen. All rights reserved.
//

import SwiftUI

class Favorites: ObservableObject {
    // the actual resorts the user has favorited
    private var resorts: Set<String>

    // the key we're using to read/write in UserDefaults
    private let saveKey = "Favorites"

    init() {
        // load our saved data
        let userDefaults = UserDefaults.standard
        
        if let resorts = userDefaults.object(forKey: saveKey) as? [String] {
            self.resorts = Set(resorts)
            
            return
        }

        // still here? Use an empty array
        self.resorts = []
    }

    // returns true if our set contains this resort
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    // adds the resort to our set, updates all views, and saves the change
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }

    // removes the resort from our set, updates all views, and saves the change
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }

    func save() {
        // write out our data
        let userDefaults = UserDefaults.standard
        
        userDefaults.set(Array(resorts), forKey: saveKey)
    }
}
