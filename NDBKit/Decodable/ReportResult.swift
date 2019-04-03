//
//  ReportResult.swift
//  NDBKit
//
//  Created by Tung CHENG on 2019/3/31.
//  Copyright © 2019 Tung CHENG. All rights reserved.
//

import Foundation

public struct ReportResponse: Decodable {
    public let foods: [ReportResult]
}

public struct ReportResult: Decodable {
    public let food: Food
    
    public struct Food: Decodable {
        let nutrients: [Nutrient]
    }
}

public struct Nutrient: Decodable {
    public let nutrientId: String
    public let name: String
    public let value: String
    public let unit: String
    public let group: String
    
    public enum Group: String, Decodable, CaseIterable {
        case proximate = "Proximates"
        case mineral = "Minerals"
        case vitamin = "Vitamins"
    }
}

extension Nutrient {
    private enum CodingKeys: String, CodingKey {
        case nutrientId = "nutrient_id"
        case name
        case value
        case unit
        case group
    }
}

extension Nutrient: CustomStringConvertible {
    public var description: String {
        return String(format: "%@%@", value, unit)
    }
}
