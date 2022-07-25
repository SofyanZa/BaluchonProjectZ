//
//  CurrencyTests.swift
//  BaluchonProject
//
//  Created by Sofyan Zarouri on 18/07/2022
//  Copyright © 2022 Sofyan Zarouri. All rights reserved.
//


import XCTest
@testable import BaluchonProjectZ

class CurrencyTests: XCTestCase {
    
    let currency = Currency(rates: ["USD": 1.092908])
    
    // test if currency return a correct result
    func testCurrencyConvertShouldReturnCorrectResult() {
        let result = currency.convert(value: 1, from: "EUR", to: "USD")
        XCTAssertEqual(result, 1.092908)
    }
    
}
