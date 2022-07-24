//
//  ErrorCases.swift
//  BaluchonProject
//
//  Created by Sofyan Zarouri on 18/07/2022
//  Copyright © 2022 Sofyan Zarouri. All rights reserved.
//

import Foundation

// Enumération des erreurs possible dans l'application
enum ErrorCases: Error {
    case invalidRequest
    case errorDecode
    case errorNetwork
}
