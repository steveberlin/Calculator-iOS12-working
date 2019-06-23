//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by Steve Berlin on 6/21/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation

struct CalculatorLogic {
    
    // make the var number private to keep it from being accidently modified outside this code block (struct)
    private var number: Double?  // global variable
    
    var isFinishedChainingCalculations: Bool = true
    
    // made an optional (using the ? at the end of the type declaration) because the tuple may (and probably will) have a value of nil when
    // a new object is created using this structure.
    private var firstCalculation: (n1: Double, calcMethod: String)?
    private var secondCalculation: (n1: Double, calcMethod: String)?
    
    // mutating tells the complier that this method is capable of changing the properties (in this case the global variable number) inside the struct.
    // That way the compiler knows to make a brand new copy of the struct when the function is run so it can update the property
    mutating func setNumber(_ number: Double) { // "_" takes the place of an external parameter name, no parameter name is used when calling this function
        self.number = number // setting the global variable number equal to the local variable "number" that was passed in through the method func setNumber
    }
    
    mutating func calculate(symbol: String) -> Double? {
        
        if let n = number { // unwrap the optional incoming variable n (the number you are acting on)
            
            if isFinishedChainingCalculations {
                if symbol == "=" || symbol == "AC" {
                    return nil
                } else {
                    firstCalculation = (n1: n, calcMethod: symbol)
                    isFinishedChainingCalculations = false
                }

            } else {
                switch symbol {
                case "+/-" :
                    return n * -1  // displayValue *= -1
                case "%" :
                    return n / 100 // displayValue */ 100)
                case "AC" :
                    self.number = 0
                    firstCalculation = nil
                    secondCalculation = nil
                    isFinishedChainingCalculations = true
                    return 0
//                case "=" :
//                    return performTwoNumberCalculation(n2: n)
                default : // one of the remaining calc keys, ie; =, +, 1, *, or / was pressed
                    // save the first number and the calc symbol in a touple for later use
                    if secondCalculation == nil {
                        secondCalculation = (n1: n, calcMethod: symbol)
                    }
                    return performTwoNumberCalculation()
                }
            }
        }
        
        return nil

    }
    
    mutating private func performTwoNumberCalculation() -> Double? { // private because shouldn't be called outside this struct
        var result: Double
        // read below as:
        // if intermediateCalculation is NOT nil then bind (set equal) n1 = intermediateCalculation.n1 and (this is optional chaining)
        // if intermediateCalculation is NOT nil then bind (set equal) operation = intermediateCalculation.calcMethod
        if let n1 = firstCalculation?.n1, let operation = firstCalculation?.calcMethod, let n2 = secondCalculation?.n1, let operation2 = secondCalculation?.calcMethod { // optional chaning
            switch operation {
//            case "=" :
//                return
            case "+" :
                result = n1 + n2
                if operation2 == "=" {
                    firstCalculation = (n1: result, calcMethod: operation)
                    secondCalculation = (n1: n2, calcMethod: "=")
                } else {
                    firstCalculation = (n1: result, calcMethod: operation2)
                    secondCalculation = nil
                    
                }
                return result
            case "-" :
                result = n1 - n2
                if operation2 == "=" {
                    firstCalculation = (n1: result, calcMethod: operation)
                    secondCalculation = (n1: n2, calcMethod: "=")
                } else {
                    firstCalculation = (n1: result, calcMethod: operation2)
                    secondCalculation = nil
                }
                return result
            case "×" :
                result = n1 * n2
                if operation2 == "=" {
                    firstCalculation = (n1: result, calcMethod: operation)
                    secondCalculation = (n1: n2, calcMethod: "=")
                } else {
                    firstCalculation = (n1: result, calcMethod: operation2)
                    secondCalculation = nil
                }
                return result
            case "÷" :
                result = n1 / n2
                if operation2 == "=" {
                    firstCalculation = (n1: result, calcMethod: operation)
                    secondCalculation = (n1: n2, calcMethod: "=")
                } else {
                    firstCalculation = (n1: result, calcMethod: operation2)
                    secondCalculation = nil
                }
                return result
            default:
                fatalError("Calculator: The operation passed in does not match any of the cases.")
            }
        }
        return nil
    }
    
}
