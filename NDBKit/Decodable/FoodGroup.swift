//
//  FoodGroup.swift
//  NDBKit
//
//  Created by Tung CHENG on 2019/4/2.
//  Copyright © 2019 Tung CHENG. All rights reserved.
//

import Foundation

public enum FoodGroup: Int, Decodable, CaseIterable {
    
    case dairyAndEgg                // "Dairy and Egg Products"
    case spicesAndHerb              // "Spices and Herbs"
    case babyFood                   // "Baby Foods"
    case fatAndOil                  // "Fats and Oils"
    case poultryProduct             // "Poultry Products"
    case soupsSaucesAndGravies      // "Soups, Sauces, and Gravies"
    case sausageAndLuncheonMeat     // "Sausages and Luncheon Meats"
    case breakfastCereal            // "Breakfast Cereals"
    case fruitAndFruitJuices        // "Fruits and Fruit Juices"
    case porkProduct                // "Pork Products"
    case vegetable                  // "Vegetables and Vegetable Products"
    case nutAndSeed                 // "Nut and Seed Products"
    case beefProduct                // "Beef Products"
    case beverages                  // "Beverages"
    case finFishAndShellfish        // "Finfish and Shellfish Products"
    case legume                     // "Legumes and Legume Products"
    case lambVealAndGame            // "Lamb, Veal, and Game Products"
    case bakedProduct               // "Baked Products"
    case sweets                     // "Sweets"
    case cerealGrainAndPasta        // "Cereal Grains and Pasta"
    case fastFood                   // "Fast Foods"
    case mealEntreeAndSideDishes    // "Meals, Entrees, and Side Dishes"
    case snack = 25                 // "Snacks"
    case americanNativeFood = 35    // "American Indian/Alaska Native Foods"
    case restaurantFood = 36        // "Restaurant Foods"
}

extension FoodGroup {
    internal var id: String {
        return String(format: "%01d00", rawValue)
    }
}

extension FoodGroup: CustomStringConvertible {
    public var description: String {
        switch self {
        case .dairyAndEgg:                return "Dairy and Egg Products"
        case .spicesAndHerb:              return "Spices and Herbs"
        case .babyFood:                   return "Baby Foods"
        case .fatAndOil:                  return "Fats and Oils"
        case .poultryProduct:             return "Poultry Products"
        case .soupsSaucesAndGravies:      return "Soups, Sauces, and Gravies"
        case .sausageAndLuncheonMeat:     return "Sausages and Luncheon Meats"
        case .breakfastCereal:            return "Breakfast Cereals"
        case .fruitAndFruitJuices:        return "Fruits and Fruit Juices"
        case .porkProduct:                return "Pork Products"
        case .vegetable:                  return "Vegetables and Vegetable Products"
        case .nutAndSeed:                 return "Nut and Seed Products"
        case .beefProduct:                return "Beef Products"
        case .beverages:                  return "Beverages"
        case .finFishAndShellfish:        return "Finfish and Shellfish Products"
        case .legume:                     return "Legumes and Legume Products"
        case .lambVealAndGame:            return "Lamb, Veal, and Game Products"
        case .bakedProduct:               return "Baked Products"
        case .sweets:                     return "Sweets"
        case .cerealGrainAndPasta:        return "Cereal Grains and Pasta"
        case .fastFood:                   return "Fast Foods"
        case .mealEntreeAndSideDishes:    return "Meals, Entrees, and Side Dishes"
        case .snack:                         return "Snacks"
        case .americanNativeFood:         return "American Indian/Alaska Native Foods"
        case .restaurantFood:             return "Restaurant Foods"
        }
    }
}
