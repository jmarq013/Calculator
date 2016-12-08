//
//  ViewController.swift
//  Calculator
//
//  Created by Julio Marquez on 6/22/16.
//  Copyright © 2016 Julio Marquez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var display: UILabel!
    
    private var userIsInTheMiddleOfTyping = false
    
    private var decimalPressed = false
    
    @IBAction private func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping {
            
            if digit == "." && decimalPressed == true {
                return
            } else if digit == "." && decimalPressed == false {
                decimalPressed = true
            }
            
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            
            if digit == "." {
                display.text = "0."
                decimalPressed = true
            } else {
                display.text = digit
            }
        }
        userIsInTheMiddleOfTyping = true
    }
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction private func performOperation(sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
            decimalPressed = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        displayValue = brain.result
    }
    
    
    @IBAction func clear() {
        display.text = "0"
        userIsInTheMiddleOfTyping = false
        decimalPressed = false
        brain.clear()

    }

}

