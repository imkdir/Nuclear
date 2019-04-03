//
//  NutrientAPI.swift
//  NDBKit
//
//  Created by Tung CHENG on 2019/3/31.
//  Copyright © 2019 Tung CHENG. All rights reserved.
//

import UIKit

public enum NutrientAPIError : Error {
    case noDataFound
    case badURL
}

final public class NutrientAPI: NSObject {
    
    static internal var dataTask: URLSessionDataTask? = nil
    
    static public func search(
        with term: String,
        group: FoodGroup? = nil,
        completion: @escaping (Result<[SearchResult], NutrientAPIError>) -> Void) {
        
        let components = SearchURLComponents(term: term, group: group)
        guard let url = components.url else {
            completion(.failure(.badURL))
            return
        }
        dataTask?.cancel()
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
                let unwrapped = try decoder.decode([String:SearchResponse].self, from: data)
                guard let results = unwrapped["list"]?.item else {
                    completion(.failure(.noDataFound))
                    return
                }
                completion(.success(results))
            } catch {
                completion(.failure(.noDataFound))
                print(error.localizedDescription)
            }
        }
        dataTask?.resume()
    }
    
    static public func report(
        for ndbno: String,
        completion: @escaping (Result<[Nutrient], NutrientAPIError>) -> Void) {
        
        let components = ReportURLComponents(ndbno: ndbno)
        guard let url = components.url else {
            completion(.failure(.badURL))
            return
        }
        dataTask?.cancel()
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
                let reportResponse = try decoder.decode(ReportResponse.self, from: data)
                guard let reportResult = reportResponse.foods.first else {
                    completion(.failure(.noDataFound))
                    return
                }
                let nutrients = reportResult.food.nutrients
                completion(.success(nutrients))
            } catch {
                completion(.failure(.noDataFound))
                print(error.localizedDescription)
            }
        }
        dataTask?.resume()
    }
}
