//
//  Translate.swift
//  BaluchonProject
//
//  Created by Sofyan Zarouri on 18/07/2022
//  Copyright © 2022 Sofyan Zarouri. All rights reserved.
//

import Foundation

// Struture to manage data

struct Translate: Decodable {
    var data: TranslationData
}

struct TranslationData: Decodable {
    var translations: [TranslationText]
}

struct TranslationText: Decodable {
    var translatedText: String
}


