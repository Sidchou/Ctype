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
    var numbColor: UIColor = UIColor.darkGray
    var opColor: UIColor = UIColor.orange
    var isNumber: Bool = true
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        //        self.layer.cornerRadius = 25
        self.clipsToBounds=true
        if isNumber {
            //            self.backgroundColor = numbColor
            self.layer.backgroundColor = numbColor.cgColor
        } else {
            self.layer.backgroundColor = opColor.cgColor
        }
    }
    
    
}
