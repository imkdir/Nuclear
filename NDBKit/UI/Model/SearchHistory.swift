//
//  SearchHistory.swift
//  Nuclear
//
//  Created by Tung CHENG on 2019/4/3.
//  Copyright © 2019 Tung CHENG. All rights reserved.
//

import Foundation

struct SearchHistory {
    
    static func log(term: String) {
        store.append(term)
    }
    
    static var length: Int {
        set {
            UserDefaults.standard.set(newValue, forKey: #function)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.integer(forKey: #function)
        }
    }
    
    static var read: [String] {
        return store.reversed()
    }
    
    static func clear() {
        store.removeAll()
    }
    
    fileprivate static var store: [String] {
        set {
            var newValue = newValue
            if length != 0, newValue.count > length {
                newValue.removeLast(length - newValue.count)
            }
            UserDefaults.standard.set(newValue, forKey: #function)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.value(forKey: #function) as? [String] ?? []
        }
    }
}
