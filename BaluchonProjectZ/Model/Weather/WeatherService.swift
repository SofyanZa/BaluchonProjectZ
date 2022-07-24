//
//  WeatherService.swift
//  BaluchonProject
//
//  Created by Sofyan Zarouri on 18/07/2022
//  Copyright © 2022 Sofyan Zarouri. All rights reserved.
//

import Foundation

final class WeatherService {
    
    // MARK: - Properties
    
    // creation d'URLSessionDataTask
    private var task: URLSessionDataTask?
    // creation d'URLSession and initialisation
    private var weatherSession = URLSession(configuration: .default)
    init(weatherSession: URLSession = URLSession(configuration: .default)) {
        self.weatherSession = weatherSession
    }
    
    // MARK: - Methods
    
    // envoie une requête à l'API OpenWeatherMap et renvoie cette réponse
    func getWeather(from city: String, callback: @escaping (Result<WeatherInfo, ErrorCases>) -> Void) {
        // clé API stockée
        guard let apiKey = ObtainApiKey().apiKey else { return }
        // ville stockée demandée par l'utilisateur
        guard let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        // compose url
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(encodedCity)&APPID=\(apiKey.keyApiWeather)&units=metric") else { return }
        task = weatherSession.dataTask(with: url) { (data, response, error) in
            // check error
            guard let data = data, error == nil else {
                callback(.failure(.errorNetwork))
                return
            }
            // check status response
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                callback(.failure(.invalidRequest))
                return
            }
            // check response JSON
            guard let responseJSON = try? JSONDecoder().decode(WeatherInfo.self, from: data) else {
                callback(.failure(.errorDecode))
                return
            }
            callback(.success(responseJSON))
        }
        task?.resume()
    }
} 


