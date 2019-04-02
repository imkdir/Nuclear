//
//  ReportURLComponents.swift
//  NDBKit
//
//  Created by Tung CHENG on 2019/3/31.
//  Copyright © 2019 Tung CHENG. All rights reserved.
//

import Foundation

public enum ReportStyle: String {
    case basic = "b"
    case full = "f"
    case stats = "s"
}

public struct ReportURLComponents {
    private let scheme = "https"
    private let host = "api.nal.usda.gov"
    private let path = "/ndb/V2/reports"
    private let apiKey = "LwBzXiWnz6SQbOdWOT9ZmTsNf45KGguwRNaJUr3c" // FIXME: private information
    
    /// NDB number
    public var ndbno: String
    
    /// Report type
    public var reportStyle: ReportStyle
    
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
        
        let ndbnoQueryItem = URLQueryItem(name: "ndbno", value: self.ndbno)
        queryItems.append(ndbnoQueryItem)
        let groupQueryItem = URLQueryItem(name: "type", value: self.reportStyle.rawValue)
        queryItems.append(groupQueryItem)
        let apiKeyQueryItem = URLQueryItem(name: "api_key", value: self.apiKey)
        queryItems.append(apiKeyQueryItem)
        
        return queryItems
    }
}

extension ReportURLComponents {
    public init(ndbno: String) {
        self.init(ndbno: ndbno, reportStyle: .basic)
    }
}
