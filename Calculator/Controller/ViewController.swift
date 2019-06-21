//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2018.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    var isFinishedTypingNumber: Bool = true
    
    private var displayValue: Double {
        get {
            guard let number = Double(displayLabel.text!) else {
                fatalError("Calculator: Cannot convert display label text to a Double!")
            }
            return number
        }
        set {
            displayLabel.text = String(newValue)
        }
    }
   
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        //What should happen when a non-number button is pressed
    
        isFinishedTypingNumber = true
        
        if let calcMethod = sender.currentTitle {
            
            let calculator = CalculatorLogic(n: displayValue)
            
            guard let result = calculator.calculate(symbol: calcMethod) else {fatalError("Calculator: The result of the calculation is nil.")}
            
            displayValue = result
        }
        
    }

    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        //What should happen when a number is entered into the keypad
    
        if let numValue = sender.currentTitle {

                if isFinishedTypingNumber {
                    displayLabel.text = numValue
                    isFinishedTypingNumber = false
                    
                } else {
                    
                    if numValue == "." {

                        // floor() rounds down to nearest whole number
                        // compairs rounded value of display to non-rounded value of display.
                        // if they are the same then the display is an integer.
// What above conditions where the display value is a whole number integer, like 8.0?  T
// This will allow an additional . to be added to the display value.
// Because floor(8.0) == 8.0 is true
                        let isInt = floor(displayValue) == displayValue
                        // if display is not an integer (ie; there is a decimal in the display value, eg; 8.3)
                        // then exit the function by using the return command.
                        if !isInt {
                            return
                        }
                    }
                    
                    displayLabel.text?.append(contentsOf: numValue)
                }
        
        }

        
    }

}

