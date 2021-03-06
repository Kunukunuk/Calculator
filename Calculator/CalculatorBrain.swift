//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Kun Huang on 12/31/17.
//  Copyright © 2017 Kun Huang. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    private var accumulator: Double?
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double,Double) -> Double)
        case equals
    }
    
    private var operation: Dictionary<String,Operation> =
    [
    "π" : Operation.constant(Double.pi),
    "√" : Operation.unaryOperation(sqrt),
    "cos" : Operation.unaryOperation(cos),
    "±" : Operation.unaryOperation({ -$0 }),
    "x" : Operation.binaryOperation({ $0 * $1 }),
    "÷" : Operation.binaryOperation({ $0 / $1 }),
    "+" : Operation.binaryOperation({ $0 + $1 }),
    "-" : Operation.binaryOperation({ $0 - $1 }),
    "=" : Operation.equals
    
    ]
    mutating func performOperation(_ symbol: String) {
        if let operation = operation[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                if accumulator != nil {
                    pendingBinaryoperation = pendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
            }
        }
    }
    
    private mutating func performPendingBinaryOperation() {
        if pendingBinaryoperation != nil && accumulator != nil {
            accumulator = pendingBinaryoperation!.perform(with: accumulator!)
            pendingBinaryoperation = nil
        }
    }
    
    private var pendingBinaryoperation: pendingBinaryOperation?
    
    private struct pendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }
}
