//
//  SimultaneuousEqns.swift
//  MathApp
//
//  Created by Anuda Weerasinghe on 6/26/18.
//  Copyright © 2018 Anuda Weerasinghe. All rights reserved.
//

import UIKit
import SCLAlertView
import TTGSnackbar

class SimultaneuousEqns: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var eqn1Text:UILabel!
    @IBOutlet weak var eqn2Text:UILabel!
    @IBOutlet weak var xAnsText: UITextField!
    @IBOutlet weak var yAnsText: UITextField!
    
    var a:Int!
    var b:Int!
    var c:Int!
    var d:Int!
    var e:Int!
    var f:Int!
    
    var DX:Double!
    var DY: Double!
    var x: Double!
    var y: Double!
    
    var ansX:String!
    var ansY:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.xAnsText.delegate = self
        self.yAnsText.delegate = self

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        xAnsText.resignFirstResponder()
        yAnsText.resignFirstResponder()
        nextOnClick("")
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        genEqns()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func nextOnClick(_ sender: Any) {
        if(xAnsText.text == "" || yAnsText.text == ""){
            
            let alertView = SCLAlertView()
            
            alertView.showNotice("No Answers", subTitle: "You have not calculated values for both values of x. Please try again")
        }else if(xAnsText.text == "" && yAnsText.text == ""){

            let alertView = SCLAlertView()
            
            alertView.showNotice("No Answers", subTitle: "You have not calculated values for both values of x. Please try again")
        }else{
            checkAns()
        }
    }
    
    func genEqns(){
        
        xAnsText.text = ""
        yAnsText.text = ""
        
        eqn1Text.numberOfLines = 1
        eqn2Text.numberOfLines = 1
        
        let lowerValue = -10
        let upperValue = 10
        a = Int(arc4random_uniform(UInt32(upperValue - lowerValue + 1))) +   lowerValue
        b = Int(arc4random_uniform(UInt32(upperValue - lowerValue + 1))) +   lowerValue
        c = Int(arc4random_uniform(UInt32(upperValue - lowerValue + 1))) +   lowerValue
        d = Int(arc4random_uniform(UInt32(upperValue - lowerValue + 1))) +   lowerValue
        e = Int(arc4random_uniform(UInt32(upperValue - lowerValue + 1))) +   lowerValue
        f = Int(arc4random_uniform(UInt32(upperValue - lowerValue + 1))) +   lowerValue
        
        let aStr = String(a)
        let bStr = String(b)
        let cStr = String(c)
        let dStr = String(d)
        let eStr = String(e)
        let fStr = String(f)
        
        
        eqn1Text.text = aStr+"x + "+bStr+"y = "+cStr
        eqn2Text.text = dStr+"x + "+eStr+"y = "+fStr
        
        solveEqn()
        
    }
    
    func solveEqn(){
        let D:Double = Double((a*e)-(b*d))
        
        if(D != 0){
            DX = Double((c*e)-(b*f));
            
            DY = Double((a*f)-(c*d));
            
            x = Double(DX/D);
            y = Double(DY/D);
            
            if(x.isInfinite){
                genEqns()
            }else if(x.isNaN){
                genEqns()
            }else{
                let isInteger = floor(x) == x
                if(isInteger){
                    ansX = String(Int(x))
                }else{
                    ansX = String(Double(round(100*x)/100))
                }
            }
            
            if(y.isInfinite){
                genEqns()
            }else if(y.isNaN){
                genEqns()
            }else{
                let isInteger = floor(y) == y
                if(isInteger){
                    ansY = String(Int(y))
                }else{
                    ansY = String(Double(round(100*y)/100))
                }
            }
            
            print(ansX)
            print(ansY)
            
        }else{
            genEqns()
        }
    }
    
    func checkAns(){
        
        if(xAnsText.text == ansX && yAnsText.text == ansY){
            let appearance = SCLAlertView.SCLAppearance(
                showCloseButton: false
            )
            let alertView = SCLAlertView(appearance: appearance)
            alertView.addButton("Move On") {
                let snackbar = TTGSnackbar(message: "Previous Answer: x = "+self.ansX+", y = "+self.ansY, duration: .middle)
                snackbar.show()
                self.genEqns()
            }
            alertView.showSuccess("Good Job", subTitle: "You got it right!")
        }else if(xAnsText.text == ansX || yAnsText.text == ansY){
            let appearance = SCLAlertView.SCLAppearance(
                showCloseButton: false
            )
            let alertView = SCLAlertView(appearance: appearance)
            alertView.addButton("Keep Trying") {}
            alertView.addButton("Move On") {
                let snackbar = TTGSnackbar(message: "Previous Answer: x = "+self.ansX+", y = "+self.ansY, duration: .middle)
                snackbar.show()
                self.genEqns()
            }
            alertView.showNotice("Almost Right", subTitle: "Only one of your answers are correct. Remember to write your answer at most to two decimal places")
        }else{
            let appearance = SCLAlertView.SCLAppearance(
                showCloseButton: false
            )
            let alertView = SCLAlertView(appearance: appearance)
            alertView.addButton("Keep Trying") {}
            alertView.addButton("Move On") {
                let snackbar = TTGSnackbar(message: "Previous Answer: x = "+self.ansX+", y = "+self.ansY, duration: .middle)
                snackbar.show()
                self.genEqns()
            }
            alertView.showError("Wrong Answer", subTitle: "Your answers are incorrect. Remember to write your answer at most to two decimal places")
        }
        
    }
}
