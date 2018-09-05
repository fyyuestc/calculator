//
//  ViewController.swift/Users/fanyunyimac/Desktop/calculator/calculator/Base.lproj/Main.storyboard
//  calculatorDou
//  Created by fanyunyimac on 2018/8/29.
//  Copyright © 2018年 范云翼. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    var userIsInTheMiddleOfTypingANumber: Bool = false
    
    @IBAction func appenddigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        }
        else {
            display.text =  digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    var operandStack = Array<Double>()
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        print("operandStack = \(operandStack)")
    }
    
    var displayValue : Double {
        get {
            return NumberFormatter().number(from: display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        switch operation {
        case "×":
            performOperator(operation: {(op1: Double,op2: Double) -> Double in return op1*op2 })
        case "÷":
            performOperator(operation: {(op1: Double,op2: Double) -> Double in
                return op1/op2
            })
        case "➕":
            performOperator(operation: {(op1: Double,op2: Double) -> Double in
            return op1+op2
            })
        case "➖":
            performOperator(operation: {(op1: Double,op2: Double) -> Double in
            return op1-op2
            })
        default: break
        }
    }
    
    func performOperator(operation: (Double,Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(),operandStack.removeLast())
            enter()
        }
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

