//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by Steve Berlin on 6/21/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation

struct CalculatorLogic {
    
    var number: Double
    
    init(n: Double) {
        self.number = n
    }
    
    func calculate(symbol: String) -> Double? {
        
        if symbol == "+/-" {
            return number * -1  // displayValue *= -1
        } else if symbol == "%" {
            return number / 100 // displayValue */ 100)
        } else if symbol == "AC" {
            return 0
        } else {
            // return nil if no expected calculation symbol was
            // passed to the calculate function
            return nil
        }

    }
    
}
