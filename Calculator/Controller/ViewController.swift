//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2018.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var isFinishedTypingNumber: Bool = true
    
    private var calculator = CalculatorLogic()
    
    @IBOutlet weak var displayLabel: UILabel!

    
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
        
        calculator.setNumber(displayValue)
        
        if let calcMethod = sender.currentTitle { // check to make sure sender.currentTitle (the current text value of the button that was pressed) has a value (is not nil)
            
            if let result = calculator.calculate(symbol: calcMethod) {
                displayValue = result
            } else {
                // user probably pressed the = key before entering any other number(s)
                // just don't do anything
                // or maybe? set isFinishedTypingNumber = false
                //isFinishedTypingNumber = false
            }
            
            if calcMethod == "=" {
                isFinishedTypingNumber = true
            }

        }
        
    }

    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        //What should happen when a number is entered into the keypad
    
        if let numValue = sender.currentTitle {

                if isFinishedTypingNumber { // prior to typing this number user was finished, now start typing a new number
                    displayLabel.text = numValue // display the first new number in the text field
                    isFinishedTypingNumber = false // indicate user is now typing a number
                    
                } else {
                    
                    // if the "number" key pressed is the "." AND the display text already has a "." then exit the function
                    if numValue == "." && displayLabel.text!.contains(".") {
                        return
                    }
                    displayLabel.text?.append(contentsOf: numValue) // add this number to the end of existing numbers in the text field
                }
        
        }

        
    }

}

