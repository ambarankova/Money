//
//  APIManager.swift
//  Money
//
//  Created by Анастасия Ахановская on 25.09.2024.
//

import Foundation

final class ApiManager {

    private static let apiKey = "68e06ccf773b22bfe72168b5"
    private static let baseUrl = "https://v6.exchangerate-api.com/v6/"
    private static var path = "/latest/RUB"
    
    static func getNews(completion: @escaping (Result<CurrencyObject, Error>) -> ()) {
        
        let stringUrl = baseUrl + apiKey + path
        
        guard let url = URL(string: stringUrl) else { return }
        
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            handleRespond(data: data, error: error, completion: completion)
        }
        session.resume()
    }
    
    private static func handleRespond(data: Data?, error: Error?, completion: @escaping (Result<CurrencyObject, Error>) -> ()) {
        
        if let error = error {
            completion(.failure(NetworkingError.networkingError(error)))
        } else if let data = data {

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let model = try decoder.decode(CurrencyObject.self,
                                                     from: data)
                completion(.success(model))
            }
            catch let decodeError {
                completion(.failure(decodeError))
            }
        } else {
            completion(.failure(NetworkingError.unknown))
        }
    }
}
