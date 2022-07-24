//
//  ObtainApiKey.swift
//  BaluchonProject
//
//  Created by Sofyan Zarouri on 18/07/2022
//  Copyright © 2022 Sofyan Zarouri. All rights reserved.
//

import Foundation

final class ObtainApiKey {
    // récupère les clés API de ApiKeys.plist (git ignoré)
    var apiKey: ApiKeys? {
        guard let path = Bundle.main.path(forResource: "ApiKeys", ofType: "plist"), let data = FileManager.default.contents(atPath: path) else { return nil }
        guard let dataApi = try? PropertyListDecoder().decode(ApiKeys.self, from: data) else { return nil }
        return dataApi
    }
}

// structure avec le nom des clés dans le fichier plist ApiKeys
struct ApiKeys: Decodable {
    let keyApiCurrency: String
    let keyApiTranslate: String
    let keyApiWeather: String
}
