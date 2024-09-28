//
//  APIManager.swift
//  Money
//
//  Created by Анастасия Ахановская on 25.09.2024.
//

import Foundation

final class ApiManager {
    private static let apiKey = "1536896d43d94ec7f551ab4407af76d3"
    private static let baseUrl = "https://currate.ru/api/"
    private static let date = "&date=2018-02-12T15:00:00"
    private static var path = "?get=rates&pairs=USDRUB,EURRUB&key="
//    private static var path = "?get=rates&pairs=USDRUB,EURRUB" + date + "&key="
    
    static func getNews(completion: @escaping (Result<CurrencyObject, Error>) -> ()) {
        
        let stringUrl = baseUrl + path + apiKey
        
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
                let model = try JSONDecoder().decode(DataCurrency.self,
                                                     from: data)
                completion(.success(model.objects))
            }
            catch let decodeError {
                completion(.failure(decodeError))
            }
        } else {
            completion(.failure(NetworkingError.unknown))
        }
    }
}
