//
//  ViewController.swift
//  Calculator
//
//  Created by Kun Huang on 12/31/17.
//  Copyright © 2017 Kun Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    var userIsTyping = false
    
    @IBAction func pressedDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
            userIsTyping = true
        }
        
        
    }
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        
        if userIsTyping {
            brain.setOperand(displayValue)
            userIsTyping = false
        }
        
        if let operation = sender.currentTitle {
            brain.performOperation(operation)
        }
        
        if let result = brain.result {
            displayValue = result
        }
    }
}

