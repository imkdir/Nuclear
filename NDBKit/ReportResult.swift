//
//  ReportResult.swift
//  NDBKit
//
//  Created by Tung CHENG on 2019/3/31.
//  Copyright © 2019 Tung CHENG. All rights reserved.
//

import Foundation

//public struct ReportResponse: Decodable {
//    public let foods: [FoodReport]
//}

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
}

extension Nutrient {
    private enum CodingKeys: String, CodingKey {
        case nutrientId = "nutrient_id"
        case name
        case value
        case unit
    }
}

extension Nutrient: CustomStringConvertible {
    public var description: String {
        return String(format: "%@: %@%@", name, value, unit)
    }
}

public struct NutrientGroup: OptionSet {
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    internal var identifiers: [String] {
        var result: [String] = []
        
        if self.contains(.cal) { result.append("208") }
        if self.contains(.pro) { result.append("203") }
        if self.contains(.fat) { result.append("204") }
        if self.contains(.cho) { result.append("205") }
        
        return result
    }
    
    static public let cal = NutrientGroup(rawValue: 1 << 0)
    static public let pro = NutrientGroup(rawValue: 1 << 1)
    static public let cho = NutrientGroup(rawValue: 1 << 2)
    static public let fat = NutrientGroup(rawValue: 1 << 3)
    
    static public var common: NutrientGroup {
        return [.cal, .pro, .cho, .fat]
    }
}
