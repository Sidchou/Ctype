//
//  PadButton.swift
//  numberPad
//
//  Created by ching Hsi chou on 3/15/19.
//  Copyright © 2019 ching Hsi chou. All rights reserved.
//

import UIKit

class PadButton: UIButton {
    
    private var halfWidth: CGFloat {
        return bounds.width / 2
    }
    private var halfHight: CGFloat {
        return bounds.height / 2
    }
    let numbColor: UIColor = UIColor.darkGray
    let opColor: UIColor = UIColor.orange
    let cancelColor: UIColor = UIColor.red
    let submitColor: UIColor = UIColor.cyan
    var isNumber: Bool = true
    let dataTypeOperation : [String] = ["Number", "operator", "cancel", "submit"]
    
    var dataType: String = "Number"
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        //        self.layer.cornerRadius = 25
        self.clipsToBounds=true
        if dataType == "Number" {
            //            self.backgroundColor = numbColor
            self.layer.backgroundColor = numbColor.cgColor
        } else if dataType ==  "operator"{
            self.layer.backgroundColor = opColor.cgColor
        }else if dataType == "cancel"{
            self.layer.backgroundColor = cancelColor.cgColor

        } else if dataType == "submit"{
            self.layer.backgroundColor = submitColor.cgColor

        }
    }
    
    
}
