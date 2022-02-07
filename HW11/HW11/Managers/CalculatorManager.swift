//
//  CalculatorManager.swift
//  HW11
//
//  Created by Artem Mazurkevich on 06.02.2022.
//

import Foundation

class CalculatorManager {
    static let shared = CalculatorManager()
    
    private var firstNumber : Decimal?
    private var secondNumber: Decimal?
    private var lastOperation: String?
    
    func clearAll() {
        firstNumber = nil
        secondNumber = nil
        lastOperation = nil
    }
    
    func setNumber(number: String) {
        let trimmedString = number.trimmingCharacters(in: .whitespaces)
        let number = Decimal(string: trimmedString)
        
        if lastOperation == nil {
            firstNumber = number
        } else {
            secondNumber = number
        }
    }
    
    func setOperator(operation: String) -> OperationResult {
        if firstNumber == nil && secondNumber == nil {
            return OperationResult(stringValue: nil, needToClear: false)
        }

        if lastOperation == nil {
            if isUnaryOperator(operation: operation) {
                firstNumber = getUnaryOperatorResult(operation: operation)
                return OperationResult(stringValue: firstNumber?.description, needToClear: false)
            } else {
                lastOperation = operation == "=" ? nil : operation
                return OperationResult(stringValue: nil, needToClear: true)
            }
        } else {
            if isUnaryOperator(operation: operation) {
                if operation == "%" {
                    secondNumber = getUnaryOperatorResult(operation: operation)
                    firstNumber = getBinaryOperatorResult(operation: lastOperation!)
                    secondNumber = nil
                    lastOperation = nil
                    return OperationResult(stringValue: firstNumber?.description, needToClear: true)
                } else {
                    secondNumber = getUnaryOperatorResult(operation: operation)
                    return OperationResult(stringValue: secondNumber?.description, needToClear: false)
                }
            } else {
                firstNumber = getBinaryOperatorResult(operation: lastOperation!)
                secondNumber = nil
                lastOperation = operation == "=" ? nil : operation
                return OperationResult(stringValue: firstNumber?.description, needToClear: true)
            }
        }
    }
    
    private func isUnaryOperator(operation: String) -> Bool {
        return operation == "⁺∕₋" || operation == "%"
    }
    
    private func getUnaryOperatorResult(operation: String) -> Decimal? {
        switch operation {
        case "⁺∕₋":
            if secondNumber == nil && firstNumber != nil {
                return -firstNumber!
            } else if firstNumber != nil && secondNumber != nil {
                return -secondNumber!
            } else {
                return nil
            }
        case "%":
            if secondNumber == nil && firstNumber != nil {
                return firstNumber! / 100
            } else if firstNumber != nil && secondNumber != nil {
                return (firstNumber! * secondNumber!) / 100
            } else {
                return nil
            }
        default:
            return nil
        }
    }
    
    private func getBinaryOperatorResult(operation: String) -> Decimal? {
        switch operation {
        case "+":
            return firstNumber! + secondNumber!
        case "-":
            return firstNumber! - secondNumber!
        case "×":
            return firstNumber! * secondNumber!
        case "÷":
            return firstNumber! / secondNumber!
        default:
            return nil
        }
    }
}
