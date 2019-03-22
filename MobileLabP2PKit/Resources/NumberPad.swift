//
//  NumberPad.swift
//  numberPad
//
//  Created by ching Hsi chou on 3/14/19.
//  Copyright © 2019 ching Hsi chou. All rights reserved.
//

import UIKit

class NumberPad: UIView {
    
    private struct container{
        //320X360
        //        static let boarder = 50
        static let boarder = 0.15
        //        static let size = 60
        static let size = 0.17
    }
    private var halfWidth: CGFloat {
        return bounds.width / 2
    }
    private var size: CGFloat {
        return bounds.width * CGFloat(container.size)
    }
    private var boarder: CGFloat {
        return bounds.width * CGFloat(container.boarder)
    }

    
    //    private var halfHight: CGFloat {
    //        return bounds.height / 2
    //    }
    
    @IBInspectable var cols: Int = 4
    @IBInspectable var rows: Int = 4
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        //    func viewDidLoad(_ rect: CGRect) {
        print("numberPad")
        
        let offset = 2*(self.halfWidth-CGFloat(boarder))/(CGFloat(cols)-1)
        // Drawing code
        var index = 0
        while index < 16 {
            //set x,y position
            
            var xPos = CGFloat(index).truncatingRemainder(dividingBy: 4)
            xPos-=1.5
            xPos*=offset
            xPos+=center.x
            var yPos = CGFloat(index/4)
            yPos.round(.down)
            yPos+=1
            yPos=yPos*offset-(CGFloat(size)/2)
            
            
            print(xPos,yPos)
            //            yPos+=offsetY
            let numberKeys = PadButton(frame: CGRect(x: 0, y: 0, width: size, height: size))
            numberKeys.center = CGPoint(x:CGFloat(xPos), y:CGFloat(yPos))
            //            numberKeys.fillColor = UIColor.gray
            //            numberKeys.backgroundColor = UIColor.gray
            if CGFloat(index).truncatingRemainder(dividingBy: 4)==3.0 {
                numberKeys.isNumber = false
            }
            numberKeys.layer.cornerRadius = CGFloat(size/2)
            numberKeys.setTitle(String(index+1), for: UIControl.State.normal)
            numberKeys.addTarget(self, action: Selector(("numberKeysPressed:")), for: UIControl.Event.touchUpInside)
            self.addSubview(numberKeys)
            index += 1
        }
        
    }
    
    func numberKeysPressed(){}
    
}



