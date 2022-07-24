//
//  CurrencyService.swift
//  BaluchonProject
//
//  Created by Sofyan Zarouri on 18/07/2022
//  Copyright © 2022 Sofyan Zarouri. All rights reserved.
//

import Foundation

final class CurrencyService {
    
    // MARK: - Properties
    
    // creation d'URLSessionsDataTask
    private var task: URLSessionDataTask?
    // creation d'URLSession
    private var currencySession: URLSession
    // initialisation d'URLSession
    init(currencySession: URLSession = URLSession(configuration: .default)) {
        self.currencySession = currencySession
    }
    
    // MARK: - Method
    
    /// envoie une requête à l'API Fixer et renvoie une réponse
    func getRate(callback: @escaping (Result<Currency, ErrorCases>) -> Void) {
        // clé API stockée
        guard let apiKey = ObtainApiKey().apiKey else { return }
        // on compose l'url
        guard let url = URL(string: "https://api.apilayer.com/fixer/latest?base=EUR&symbols=USD&apikey=\(apiKey.keyApiCurrency)") else { return }
        task?.cancel()
        task = currencySession.dataTask(with: url) { (data, response, error) in
            // vérification erreur
            guard let data = data, error == nil else {
                callback(.failure(.errorNetwork))
                return
            }
            // vérifier la réponse
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                callback(.failure(.invalidRequest))
                return
            }
            // vérifier la reponse au format json
            guard let responseJSON = try? JSONDecoder().decode(Currency.self, from: data) else {
                callback(.failure(.errorDecode))
                return
            }
            callback(.success(responseJSON))
        }
        task?.resume()
    }
}
