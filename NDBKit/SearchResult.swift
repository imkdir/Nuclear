//
//  SearchResult.swift
//  NDBKit
//
//  Created by Tung CHENG on 2019/3/31.
//  Copyright © 2019 Tung CHENG. All rights reserved.
//

import Foundation

public struct SearchResponse: Decodable {
    public let item: [SearchResult]
}

/// A result returned from the NDB Search API.
public struct SearchResult: Decodable {
    /// the food's NDB Number
    public let ndbno: String
    /// the food’s name
    public let name: String
    /// food group to which the food belongs
    public let group: String
}

extension SearchResult {
    private enum CodingKeys: String, CodingKey {
        case ndbno
        case name
        case group
    }
}

extension SearchResult: CustomStringConvertible {
    public var description: String {
        return [ndbno, name].joined(separator: ":")
    }
}
