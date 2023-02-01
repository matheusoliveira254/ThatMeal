//
//  MealListDataProvider.swift
//  ThatMeal
//
//  Created by Matheus Oliveira on 2/1/23.
//

import Foundation

protocol MealListServiceable {
    func fetchMealsInCategories(with category: String, completion: @escaping (Result<TopLevelDictionaryMeals, NetworkError>) -> Void)
}

struct MealListService: MealListServiceable {
    
    private let service = APIService()
    private let baseURL = "https://www.themealdb.com/api/json/v1/1"
    
    func fetchMealsInCategories(with category: String, completion: @escaping (Result<TopLevelDictionaryMeals, NetworkError>) -> Void) {
        let filterPath = "filter.php"
        let cKey = "c"
        let cKeyValue = category
        
        guard let baseURL = URL(string: baseURL) else {completion(.failure(.badURL)); return}
        let filterPathComponent = baseURL.appending(path: filterPath)
        let cQueryItem = URLQueryItem(name: cKey, value: cKeyValue)
        var urlComponents = URLComponents(url: filterPathComponent, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [cQueryItem]
        guard let finalURL = urlComponents?.url else {completion(.failure(.badURL)); return}
        print(finalURL)
        let request = URLRequest(url: finalURL)
        
        service.perform(request) { result in
            switch result {
            case .success(let meals):
                do {
                    let meals = try JSONDecoder().decode(TopLevelDictionaryMeals.self, from: meals)
                    completion(.success(meals))
                } catch {
                    completion(.failure(.errorDecoding(error)))
                }
            case .failure(let error):
                completion(.failure(.requestError(error)))
            }
        }
    }
}//End of struct
