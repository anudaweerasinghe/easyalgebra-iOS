//
//  ViewController.swift
//  MathApp
//
//  Created by Anuda Weerasinghe on 6/26/18.
//  Copyright © 2018 Anuda Weerasinghe. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var factLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getMathFact()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getMathFact(){
        factLabel.numberOfLines = 10
        
        Alamofire.request("http://numbersapi.com/random/math", method:.get).responseString{(response)->Void in
            response.result.ifSuccess {
                self.factLabel.text=response.result.value
            }
            response.result.ifFailure {
                self.factLabel.text="Error retrieving the Math Fact"
            }
        }
    }
}

