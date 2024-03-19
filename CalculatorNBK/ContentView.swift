//
//  ContentView.swift
//  CalculatorNBK
//
//  Created by Naser on 18/03/2024.
//

import SwiftUI

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    
    var firstNumber = ""
    var secondNumber = ""
    var currentOperation = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func numberButtonPressed(_ sender: UIButton) {
        guard let digit = sender.title(for: .normal) else { return }
        displayLabel.text! += digit
    }
    
    @IBAction func operationButtonPressed(_ sender: UIButton) {
        guard let operation = sender.title(for: .normal) else { return }
        if !displayLabel.text!.isEmpty {
            firstNumber = displayLabel.text!
            currentOperation = operation
            displayLabel.text = ""
        }
    }
    
    @IBAction func equalsButtonPressed(_ sender: UIButton) {
        if !displayLabel.text!.isEmpty {
            secondNumber = displayLabel.text!
            let num1 = Double(firstNumber)!
            let num2 = Double(secondNumber)!
            var result = 0.0
            switch currentOperation {
            case "+":
                result = num1 + num2
            case "-":
                result = num1 - num2
            case "*":
                result = num1 * num2
            case "/":
                if num2 != 0 {
                    result = num1 / num2
                } else {
                    displayLabel.text = "Try again, error"
                    return
                }
            default:
                break
            }
            displayLabel.text = "\(result)"
        }
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        displayLabel.text = ""
        firstNumber = ""
        secondNumber = ""
        currentOperation = ""
    }
}

