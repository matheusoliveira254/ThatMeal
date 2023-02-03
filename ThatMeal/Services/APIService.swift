//
//  APIService.swift
//  ThatMeal
//
//  Created by Matheus Oliveira on 1/20/23.
//

import Foundation

//Generic func that checks for data, error, response from a provided url
struct APIService {
    func perform(_ request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(.requestError(error)))
            }
            if let response = response as? HTTPURLResponse {
                print("\(response.statusCode)")
            }
            guard let data else {completion(.failure(.couldNotUnwrap)); return}
            completion(.success(data))
        }.resume()
    }
}//End of struct
