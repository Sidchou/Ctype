//
//  inputViewController.swift
//  MobileLabP2PKit
//
//  Created by ching Hsi chou on 3/22/19.
//  Copyright © 2019 Line Break, LLC. All rights reserved.
//

import UIKit

//change text protocal for child view (inputfield) to call
protocol ChangeTextPtotocol {
    func changeText(_: String)
}
class inputViewController: UIViewController,ChangeTextPtotocol {
    
    
    @IBOutlet var inputField: NumberPad!
    @IBOutlet weak var inputs: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.inputField=NumberPad()
        self.inputField.delegate = self
        print("input")

//    inputField.backgroundColor = .black
        // Do any additional setup after loading the view.
    }
    
    
    //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//
    //trying to run tis function!!!!!!!!!!!!!!!
    func changeText(_ numbText:String) {
        if numbText != nil {inputs.text = numbText}
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
//    func changeText(text:String?){
//        if text != nil {inputs.text=text}
//    }
    

}
