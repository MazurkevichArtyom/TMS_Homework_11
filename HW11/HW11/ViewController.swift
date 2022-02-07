//
//  ViewController.swift
//  HW11
//
//  Created by Artem Mazurkevich on 05.02.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var calculatorLabel: UILabel!
    
    private var needToClear = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onNumberButton(_ sender: UIButton) {
        let numberString = sender.titleLabel!.text!.trimmingCharacters(in: .whitespaces)
        setNumber(input: numberString)
    }
    
    @IBAction func onOperatorButton(_ sender: UIButton) {
        let operation = sender.titleLabel!.text!
        setOperator(input: operation)
    }
    
    @IBAction func onClearButton(_ sender: Any) {
        resetState()
    }
    
    private func setOperator(input: String) {
        CalculatorManager.shared.setNumber(number: calculatorLabel.text!)
        let result = CalculatorManager.shared.setOperator(operation: input)

        if let resultStringValue = result.stringValue {
            calculatorLabel.text = resultStringValue
        }

        needToClear = result.needToClear
    }
    
    private func setNumber(input: String) {
        if calculatorLabel.text == "0" || needToClear {
            if input == "." {
                calculatorLabel.text = "0."
            } else {
                calculatorLabel.text = input
            }
        } else {
            if !(input == "." && calculatorLabel.text!.contains(".")) {
                calculatorLabel.text! += input
            }
        }

        needToClear = false
    }
    
    private func resetState() {
        calculatorLabel.text = "0"
        needToClear = false
        CalculatorManager.shared.clearAll()
    }
}

