//
//  SearchURLComponents.swift
//  NDBKit
//
//  Created by Tung CHENG on 2019/3/31.
//  Copyright © 2019 Tung CHENG. All rights reserved.
//

import Foundation

public enum DataSource: String {
    case brandedFoodProducts = "Branded Food Products"
    case standardReference = "Standard Reference"
}

public enum SearchSort: String {
    case foodName = "n"
    case relevance = "r"
}

public struct SearchURLComponents {
    private let scheme = "https"
    private let host = "api.nal.usda.gov"
    private let path = "/ndb/search"
    private let apiKey = "LwBzXiWnz6SQbOdWOT9ZmTsNf45KGguwRNaJUr3c" // FIXME: private information
    
    /// Search terms
    public var term: String
    
    /// Food group
    public var group: FoodGroup?
    
    /// Data source
    public var source: DataSource
    
    public var sort: SearchSort
    
    // MARK: -
    
    public var url: URL? {
        return self.components.url
    }
    
    fileprivate var components: URLComponents {
        var components = URLComponents()
        components.scheme = self.scheme
        components.host = self.host
        components.path = self.path
        components.queryItems = self.queryItems
        
        return components
    }
    
    fileprivate var queryItems: [URLQueryItem] {
        var queryItems: [URLQueryItem] = []
        
        let termQueryItem = URLQueryItem(name: "q", value: self.term)
        queryItems.append(termQueryItem)
        
        if let group = self.group {
            let groupQueryItem = URLQueryItem(name: "fg", value: group.id)
            queryItems.append(groupQueryItem)
        }
        let sourceQueryItem = URLQueryItem(name: "ds", value: self.source.rawValue)
        queryItems.append(sourceQueryItem)
        let apiKeyQueryItem = URLQueryItem(name: "api_key", value: self.apiKey)
        queryItems.append(apiKeyQueryItem)
        let sortQueryItem = URLQueryItem(name: "sort", value: self.sort.rawValue)
        queryItems.append(sortQueryItem)
        let maxQueryItem = URLQueryItem(name: "max", value: "50")
        queryItems.append(maxQueryItem)
        
        return queryItems
    }
}

extension SearchURLComponents {
    public init(term: String, group: FoodGroup?) {
        self.init(term: term, group: group, source: .standardReference, sort: .foodName)
    }
}
