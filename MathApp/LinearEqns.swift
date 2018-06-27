//
//  LinearEqns.swift
//  MathApp
//
//  Created by Anuda Weerasinghe on 6/26/18.
//  Copyright © 2018 Anuda Weerasinghe. All rights reserved.
//

import UIKit
import SCLAlertView
import TTGSnackbar

class LinearEqns: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var eqnLabel: UILabel!
    @IBOutlet weak var ansXText: UITextField!
    
    var a:Int!
    var b:Int!
    var c:Int!
    var d:Int!
    
    var dminb:Double!
    var aminc:Double!
    var x:Double!
    var ansX:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ansXText.delegate = self

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        ansXText.resignFirstResponder()
        nextOnClick("")
        return true
    }
    
    @IBAction func nextOnClick(_ sender: Any) {
        if(ansXText.text == ""){
            
            let alertView = SCLAlertView()
            
            alertView.showNotice("No Answers", subTitle: "You have not calculated values for both X and Y. Please try again")
        }else{
            checkAns()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        genEqn()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func genEqn(){
        ansXText.text = ""
        
        let lowerValue = -10
        let upperValue = 10
        a = Int(arc4random_uniform(UInt32(upperValue - lowerValue + 1))) +   lowerValue
        b = Int(arc4random_uniform(UInt32(upperValue - lowerValue + 1))) +   lowerValue
        c = Int(arc4random_uniform(UInt32(upperValue - lowerValue + 1))) +   lowerValue
        d = Int(arc4random_uniform(UInt32(upperValue - lowerValue + 1))) +   lowerValue
        
        let aStr = String(a)
        let bStr = String(b)
        let cStr = String(c)
        let dStr = String(d)
        
        eqnLabel.text = aStr+"x + "+bStr+" = "+cStr+"x + "+dStr
        
        solveEqn()
    }
    
    func solveEqn(){
        
        dminb = Double(d - b);
        
        aminc = Double(a - c);
        
        x = dminb / aminc;
        
        if(x.isInfinite){
            genEqn()
        }else if(x.isNaN){
            genEqn()
        }else{
            let isInteger = floor(x) == x
            if(isInteger){
                ansX = String(Int(x))
            }else{
                ansX = String(Double(round(100*x)/100))
            }
            print(ansX)

        }
    }
    
    func checkAns(){
        if(ansXText.text==ansX){
            let appearance = SCLAlertView.SCLAppearance(
                showCloseButton: false
            )
            let alertView = SCLAlertView(appearance: appearance)
            alertView.addButton("Move On") {
                let snackbar = TTGSnackbar(message: "Previous Answer: x = "+self.ansX, duration: .middle)
                snackbar.show()
                self.genEqn()
            }
            alertView.showSuccess("Good Job", subTitle: "You got it right!")
        }else{
            let appearance = SCLAlertView.SCLAppearance(
                showCloseButton: false
            )
            let alertView = SCLAlertView(appearance: appearance)
            alertView.addButton("Keep Trying") {}
            alertView.addButton("Move On") {
                let snackbar = TTGSnackbar(message: "Previous Answer: x = "+self.ansX, duration: .middle)
                snackbar.show()
                self.genEqn()
            }
            alertView.showError("Wrong Answer", subTitle: "Your answers are incorrect. Remember to write your answer at most to two decimal places")
        }
    }
    
}
