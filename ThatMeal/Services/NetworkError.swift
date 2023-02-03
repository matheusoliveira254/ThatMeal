//
//  NetworkError.swift
//  ThatMeal
//
//  Created by Matheus Oliveira on 1/20/23.
//

import Foundation
/// Error Object for throwing errors on concurrent tasks
enum NetworkError: Error, LocalizedError {
    case unexpectedError
    case requestError(Error)
    case badURL
    case couldNotUnwrap
    case errorDecoding(Error)
    
    var localizedDescription: String {
        switch self {
        case .requestError(let error):
            return "Error performing the task: \(error.localizedDescription)"
        case .badURL:
            return "Unable to make the request with the given URL"
        case .couldNotUnwrap:
            return "Error parsing requested data"
        case .errorDecoding:
            return "Error ecountered when decoding the data"
        case .unexpectedError:
            return "Hmm.. Something went wrong"
        }
    }
}
