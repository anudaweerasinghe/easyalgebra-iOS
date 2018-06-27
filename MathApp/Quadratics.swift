//
//  Quadratics.swift
//  MathApp
//
//  Created by Anuda Weerasinghe on 6/26/18.
//  Copyright © 2018 Anuda Weerasinghe. All rights reserved.
//

import UIKit

import SCLAlertView
import TTGSnackbar

class Quadratics: UIViewController {
    
    @IBOutlet weak var eqnLabel: UILabel!
    @IBOutlet weak var x1Label: UITextField!
    @IBOutlet weak var x2Label: UITextField!
    
    var a:Int!
    var b:Int!
    var c:Int!
    
    var d:Double!
    var x1:Double!
    var x2:Double!
    
    var ansX1:String!
    var ansX2:String!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        genEqn()
    }
    
    @IBAction func onNextClick(_ sender: Any) {
        if(x1Label.text == "" || x2Label.text == ""){
            
            let alertView = SCLAlertView()
            
            alertView.showNotice("No Answers", subTitle: "You have not calculated values for both X and Y. Please try again")
        }else if(x1Label.text == "" && x2Label.text == ""){
            
            let alertView = SCLAlertView()
            
            alertView.showNotice("No Answers", subTitle: "You have not calculated values for both X and Y. Please try again")
        }else{
            checkAns()
        }
    }
    func genEqn(){
        x1Label.text = ""
        x2Label.text = ""
        
        let lowerValue = -10
        let upperValue = 10
        a = Int(arc4random_uniform(UInt32(upperValue - lowerValue + 1))) +   lowerValue
        b = Int(arc4random_uniform(UInt32(upperValue - lowerValue + 1))) +   lowerValue
        c = Int(arc4random_uniform(UInt32(upperValue - lowerValue + 1))) +   lowerValue

        
        d = (pow(Double(b), 2.0)) - Double(4*a*c)
        
        if(a == 0){
            genEqn()
        }else if(d<0){
            genEqn()
        }else{
            let aStr = String(a)
            let bStr = String(b)
            let cStr = String(c * -1)
            
            eqnLabel.text = aStr+"x² +"+" "+bStr+"x = "+cStr
            
            solveEqn()
        }

    }
    
    func solveEqn(){
        x1 = (Double(-b)+(d.squareRoot()))/Double(2*a)
        x2 = (Double(-b)-(d.squareRoot()))/Double(2*a)
        
        if(x1 == -0){
            x1 = 0;
        }
        
        if(x2 == -0){
            x2 = 0;
        }
        
        if(x1.isInfinite){
            genEqn()
        }else if(x1.isNaN){
            genEqn()
        }else{
            let isInteger = floor(x1) == x1
            if(isInteger){
                ansX1 = String(Int(x1))
            }else{
                ansX1 = String(Double(round(100*x1)/100))
            }
        }
        
        if(x2.isInfinite){
            genEqn()
        }else if(x2.isNaN){
            genEqn()
        }else{
            let isInteger = floor(x2) == x2
            if(isInteger){
                ansX2 = String(Int(x2))
            }else{
                ansX2 = String(Double(round(100*x2)/100))
            }
        }
        
        print(ansX1)
        print(ansX2)

    }
    
    func checkAns(){
        if(x1Label.text == ansX1 && x2Label.text == ansX2){
            let appearance = SCLAlertView.SCLAppearance(
                showCloseButton: false
            )
            let alertView = SCLAlertView(appearance: appearance)
            alertView.addButton("Move On") {
                let snackbar = TTGSnackbar(message: "Previous Answer: x₁ = "+self.ansX1+", x₂ = "+self.ansX2, duration: .middle)
                snackbar.show()
                self.genEqn()
            }
            alertView.showSuccess("Good Job", subTitle: "You got it right!")
        }else if(x1Label.text == ansX2 && x2Label.text == ansX1){
            let appearance = SCLAlertView.SCLAppearance(
                showCloseButton: false
            )
            let alertView = SCLAlertView(appearance: appearance)
            alertView.addButton("Move On") {
                let snackbar = TTGSnackbar(message: "Previous Answer: x₁ = "+self.ansX1+", x₂ = "+self.ansX2, duration: .middle)
                snackbar.show()
                self.genEqn()
            }
            alertView.showSuccess("Good Job", subTitle: "You got it right!")
        }else if(x1Label.text == ansX2 || x2Label.text == ansX1){
            let appearance = SCLAlertView.SCLAppearance(
                showCloseButton: false
            )
            let alertView = SCLAlertView(appearance: appearance)
            alertView.addButton("Keep Trying") {}
            alertView.addButton("Move On") {
                let snackbar = TTGSnackbar(message: "Previous Answer: x₁ = "+self.ansX1+", x₂ = "+self.ansX2, duration: .middle)
                snackbar.show()
                self.genEqn()
            }
            alertView.showNotice("Almost Right", subTitle: "Only one of your answers are correct. Remember to write your answer at most to two decimal places")
        }else if(x1Label.text == ansX1 || x2Label.text == ansX2){
            let appearance = SCLAlertView.SCLAppearance(
                showCloseButton: false
            )
            let alertView = SCLAlertView(appearance: appearance)
            alertView.addButton("Keep Trying") {}
            alertView.addButton("Move On") {
                let snackbar = TTGSnackbar(message: "Previous Answer: x₁ = "+self.ansX1+", x₂ = "+self.ansX2, duration: .middle)
                snackbar.show()
                self.genEqn()
            }
            alertView.showNotice("Almost Right", subTitle: "Only one of your answers are correct. Remember to write your answer at most to two decimal places")
        }else{
            let appearance = SCLAlertView.SCLAppearance(
                showCloseButton: false
            )
            let alertView = SCLAlertView(appearance: appearance)
            alertView.addButton("Keep Trying") {}
            alertView.addButton("Move On") {
                let snackbar = TTGSnackbar(message: "Previous Answer: x₁ = "+self.ansX1+", x₂ = "+self.ansX2, duration: .middle)
                snackbar.show()
                self.genEqn()
            }
            alertView.showError("Wrong Answer", subTitle: "Your answers are incorrect. Remember to write your answer at most to two decimal places")
        }
    }


}
