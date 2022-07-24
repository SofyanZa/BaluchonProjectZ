//
//  TranslateService.swift
//  BaluchonProject
//
//  Created by Sofyan Zarouri on 18/07/2022
//  Copyright © 2022 Sofyan Zarouri. All rights reserved.
//

import Foundation

enum Language {
    case fr
    case en
    case detect
}

final class TranslateService {
    
    //  MARK: - Properties
    
    let language: [String] = ["Français > Anglais", "Anglais > Français", "Detection > Français"]
    // langue source des messages
    private var source: String = "fr"
    // langue cible des messages
    private var target: String = "en"
    // creation d'URLSession
    private var translateSession: URLSession
    // creation d'URLSessionsDataTask
    private var task: URLSessionDataTask?
    // initialisation d'URLSession
    init(translateSession: URLSession = URLSession(configuration: .default)) {
        self.translateSession = translateSession
    }
    
    // MARK: - Methods
    
    /// envoyer une requête à l'API Google Traduction et renvoyer une réponse
    func translate(language: Language, text: String, callback: @escaping (Result <Translate, ErrorCases>) -> Void) {
        // compose url
        guard let request = createTranslateRequest(text: text, language: language) else { return }
        task?.cancel()
        task = translateSession.dataTask(with: request) { (data, response, error) in
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
            guard let responseJSON = try? JSONDecoder().decode(Translate.self, from: data) else {
                callback(.failure(.errorDecode))
                return
            }
            callback(.success(responseJSON))
            return
        }
        task?.resume()
    }
    
    /// create a request based with parameter
    private func createTranslateRequest(text: String, language: Language) -> URLRequest? {
        // stock API key
        guard let apiKey = ObtainApiKey().apiKey else { return nil }
        guard let url = URL(string: "https://translation.googleapis.com/language/translate/v2?") else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // stock text to translate
        let q: String = text
        selectedLanguage(language: language)
        // stock body of the request with text, source, target and APIkey
        let body = "q=\(q)" + "&\(source)" + "&target=\(target)" + "&key=\(apiKey.keyApiTranslate)&format=text"
        request.httpBody = body.data(using: .utf8)
        return request
    }
    
    /// change source and target by the index
    private func selectedLanguage(language: Language) {
        switch language {
        case .fr :
            source = "source=fr"
            target = "en"
        case .en :
            source = "source=en"
            target = "fr"
        case .detect :
            source = "detect"
            target = "fr"
        }
    }
}

