//
//  NutrientAPI.swift
//  NDBKit
//
//  Created by Tung CHENG on 2019/3/31.
//  Copyright © 2019 Tung CHENG. All rights reserved.
//

import UIKit

final public class NutrientAPI: NSObject {
    
    static internal var dataTask: URLSessionDataTask? = nil
    
    static public func search(with term: String, group: FoodGroup? = nil, completion: @escaping ([SearchResult]) -> Void) {
        let components = SearchURLComponents(term: term, group: group)
        guard let url = components.url else {
            return
        }
        dataTask?.cancel()
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
                let unwrapped = try decoder.decode([String:SearchResponse].self, from: data)
                let results = unwrapped["list"]?.item ?? []
                completion(results)
            } catch {
                completion([])
                print(error.localizedDescription)
            }
        }
        dataTask?.resume()
    }
    
    static public func report(for ndbno: String, nutrientGroup: NutrientGroup, completion: @escaping ([Nutrient]) -> Void) {
        let components = ReportURLComponents(ndbno: ndbno)
        guard let url = components.url else {
            return
        }
        dataTask?.cancel()
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
                let reportResponse = try decoder.decode(ReportResponse.self, from: data)
                guard let reportResult = reportResponse.foods.first else {
                    completion([])
                    return
                }
                let nutrients = reportResult.food.nutrients
                let group = { (param: Nutrient) -> Bool in
                    nutrientGroup.identifiers.contains(param.nutrientId)
                }
                completion(nutrients.filter(group))
            } catch {
                completion([])
                print(error.localizedDescription)
            }
        }
        dataTask?.resume()
    }
}
