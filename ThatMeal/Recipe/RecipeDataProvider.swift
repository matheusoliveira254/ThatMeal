//
//  RecipeDataProvider.swift
//  ThatMeal
//
//  Created by Matheus Oliveira on 2/1/23.
//

import Foundation

protocol RecipeServiceable {
    func fetchRecipe(with recipeName: String,  completion: @escaping (Result<TopLevelDictionaryRecipe, NetworkError>) -> Void)
}

struct RecipeService: RecipeServiceable {
    private let service = APIService()
    private let baseURL = "https://www.themealdb.com/api/json/v1/1"
    let searchPath = "search.php"
    let sKey = "s"
    
    func fetchRecipe(with recipeName: String,  completion: @escaping (Result<TopLevelDictionaryRecipe, NetworkError>) -> Void) {
        
        guard let baseURL = URL(string: baseURL) else {completion(.failure(.badURL)); return}
        let searchPathComponent = baseURL.appending(path: searchPath)
        let sQueryItem = URLQueryItem(name: sKey, value: recipeName)
        var urlComponents = URLComponents(url: searchPathComponent, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [sQueryItem]
        guard let finalURL = urlComponents?.url else {completion(.failure(.badURL)); return}
        print(finalURL)
        let request = URLRequest(url: finalURL)
        
        service.perform(request) { result in
            switch result {
            case .success(let recipe):
                do {
                    let recipe = try JSONDecoder().decode(TopLevelDictionaryRecipe.self, from: recipe)
                    completion(.success(recipe))
                } catch {
                    completion(.failure(.errorDecoding(error)))
                }
            case .failure(let error):
                completion(.failure(.requestError(error)))
            }
        }
    }
}//End of struct
