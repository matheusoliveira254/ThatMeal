//
//  CategoriesDataSerivce.swift
//  ThatMeal
//
//  Created by Matheus Oliveira on 1/20/23.
//

import Foundation

protocol CategoriesServiceable {
    func fetchCategoriesName(completion: @escaping (Result<TopLevelDictionaryCategory, NetworkError>) -> Void)
    func fetchMealsInCategories(with category: String, completion: @escaping (Result<TopLevelDictionaryMeals, NetworkError>) -> Void)
}

struct CategoriesService: CategoriesServiceable {
    private let service = APIService()
    private let baseURL = "https://www.themealdb.com/api/json/v1/1"
    
    func fetchCategoriesName(completion: @escaping (Result<TopLevelDictionaryCategory, NetworkError>) -> Void) {
        let categoriesPath = "categories.php"
        guard let baseCategoriesURL = URL(string: baseURL) else {completion(.failure(.badURL)); return}
        let finalURL = baseCategoriesURL.appending(path: categoriesPath)
        print(finalURL)
        let request = URLRequest(url: finalURL)
        
        service.perform(request) { result in
            switch result {
            case .success(let categoriesName):
                do {
                    let categories = try JSONDecoder().decode(TopLevelDictionaryCategory.self, from: categoriesName)
                    completion(.success(categories))
                } catch {
                    completion(.failure(.errorDecoding(error)))
                }
            case .failure(let error):
                completion(.failure(.requestError(error)))
            }
        }
    }
    
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
}//End of Struct
