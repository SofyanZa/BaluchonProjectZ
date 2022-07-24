//
//  Currency.swift
//  BaluchonProject
//
//  Created by Sofyan Zarouri on 18/07/2022
//  Copyright © 2022 Sofyan Zarouri. All rights reserved.
//

import Foundation

// structure pour gérer les données et convertir

struct Currency: Decodable {
    
    var rates: [String: Double]
    
    private func convertFromEuro(value: Double, rate: Double) -> Double {
        return value * rate
    }
    
    func convert(value: Double, from: String, to: String) -> Double {
        guard let rate = rates[to] else { return 0.00 }
        let convertValue = convertFromEuro(value: value, rate: rate)
        return convertValue
    }
}

