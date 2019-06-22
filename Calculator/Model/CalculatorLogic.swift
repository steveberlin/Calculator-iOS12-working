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
    
    // made an optional (using the ? at the end of the type declaration) because the tuple may (and probably will) have a value of nil when
    // a new object is created using this structure.
    private var intermediateCalculation: (n1: Double, calcMethod: String)?
    
    // mutating tells the complier that this method is capable of changing the properties (in this case the global variable number) inside the struct.
    // That way the compiler knows to make a brand new copy of the struct when the function is run so it can update the property
    mutating func setNumber(_ number: Double) { // "_" takes the place of an external parameter name, no parameter name is used when calling this function
        self.number = number // setting the global variable number equal to the local variable "number" that was passed in through the method func setNumber
    }
    
    mutating func calculate(symbol: String) -> Double? {
        
        if let n = number { // unwrap the optional incoming variable n (the number you are acting on)
            
            switch symbol {
            case "+/-" :
                return n * -1  // displayValue *= -1
            case "%" :
                return n / 100 // displayValue */ 100)
            case "AC" :
                self.number = 0
                //intermediateCalculation = nil
                return 0
            case "=" :
                return performTwoNumberCalculation(n2: n)
            default : // one of the remaining keys, ie; +, 1, *, or / was pressed
                // save the first number and the calc symbol in a touple for later use
                intermediateCalculation = (n1: n, calcMethod: symbol)
            }
        }
        
        return nil

    }
    
    private func performTwoNumberCalculation(n2: Double) -> Double? { // private because shouldn't be called outside this struct
        // read below as:
        // if intermediateCalculation is NOT nil then bind (set equal) n1 = intermediateCalculation.n1 and (this is optional chaining)
        // if intermediateCalculation is NOT nil then bind (set equal) operation = intermediateCalculation.calcMethod
        if let n1 = intermediateCalculation?.n1, let operation = intermediateCalculation?.calcMethod { // optional chaning
            switch operation {
            case "+" :
                return n1 + n2
            case "-" :
                return n1 - n2
            case "×" :
                return n1 * n2
            case "\\" :
                return n1 / n2
            default:
                fatalError("Calculator: The operation passed in does not match any of the cases.")
            }
        }
        return nil
    }
    
}
