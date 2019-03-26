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
    
    
    var delegate: ChangeTextProtocol?
    //    private var halfHight: CGFloat {
    //        return bounds.height / 2
    //    }
    
    @IBInspectable var cols: Int = 4
    @IBInspectable var rows: Int = 4
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
//
//
//    // Only override draw() if you perform custom drawing.
//    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
//
        //    func viewDidLoad(_ rect: CGRect) {
        print("numberPad")
        
        let offset = 2*(self.halfWidth-CGFloat(boarder))/(CGFloat(cols)-1)
        // Drawing code
        var numberTitle = 1
        let operaterTitle = ["+","-","×","÷"]
        var operaterTitleIndex = 0
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
            
//            print(xPos,yPos)
            //            yPos+=offsetY
            let numberKeys = PadButton(frame: CGRect(x: 0, y: 0, width: size, height: size))
            numberKeys.center = CGPoint(x:CGFloat(xPos), y:CGFloat(yPos))
            //            numberKeys.fillColor = UIColor.gray
            //            numberKeys.backgroundColor = UIColor.gray
            if CGFloat(index).truncatingRemainder(dividingBy: 4)==3.0 {
                numberKeys.isNumber = false
            }
            numberKeys.layer.cornerRadius = CGFloat(size/2)
            numberKeys.titleLabel?.font = UIFont(name: "helvetica", size: 35)
            numberKeys.titleLabel?.textAlignment = NSTextAlignment.center
            if numberKeys.isNumber {
           if numberTitle < 10 { numberKeys.setTitle(String(numberTitle), for: UIControl.State.normal)
                numberTitle+=1
           }else{
            numberKeys.setTitle("0", for: UIControl.State.normal)
                }
            } else {
                numberKeys.setTitle(operaterTitle[operaterTitleIndex], for: UIControl.State.normal)
                operaterTitleIndex+=1
            }
            numberKeys.addTarget(self, action: #selector(numberKeysPressed), for: UIControl.Event.touchUpInside)
            self.addSubview(numberKeys)
            index += 1
//            print(numberKeys.titleLabel?.text)
        }
        
    }

//    override func layoutSubviews() {
//        super.layoutSubviews()
//    }
    

    //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//
    //trying to call the function here!!!!!!!!!!!!!!!
    var digitCount = 0
    var operationCount = 0
    var printText:String?
    @objc func numberKeysPressed(sender:PadButton!){
        var elementsArray:[String]
        var operatorArray:[String]
        var buttonKey = "\(sender.titleLabel?.text ?? "")"
        //count digit
        if sender.isNumber {
            digitCount+=1
            operationCount = 0
        }else{
            digitCount = 0
            operationCount+=1
        }
        //if less than 3, fire number
        if digitCount < 3 && operationCount < 2 {
        if printText != nil {
            //add key
            printText = "\(printText ?? "")\(buttonKey)"
            
        } else {//first key
            printText = buttonKey
        }
        print("\(printText ?? "")")
            //change input label in parent viewl controller
        self.delegate?.changeText("\(printText ?? "")")
    }else{
    print("too many numbers or operation")
        }
        elementsArray = printText?.components(separatedBy: ["+","-","×","÷"]) ?? []
        let digits = CharacterSet.decimalDigits
        operatorArray = printText?.components(separatedBy: digits) ?? []
        operatorArray = operatorArray.filter { $0 != "" }
        print("elements\(elementsArray)")
        print("operrrr\(operatorArray)")
        // variable
        let didmath = doMath(e: elementsArray,o: operatorArray)
        print(didmath)
        self.delegate?.tempAns("\(didmath)")
    }
}

// do some math
func doMath(e:[String],o:[String]) -> Int {
    if e.count > 1{
print("doing math")
    var calcResult = math(result: 0, e: e,o: o, do: "×")
    calcResult = math(result: calcResult.0, e: calcResult.1,o: calcResult.2, do: "÷")
    calcResult = math(result: calcResult.0, e: calcResult.1,o: calcResult.2, do: "+")
    calcResult = math(result: calcResult.0, e: calcResult.1,o: calcResult.2, do: "-")
    print("calcResult = \(calcResult)")
        return calcResult.0
        
    }else if let _r = Int(e[0]) {return _r} else {return 0}
    
}

// individual math
func math(result:Int, e:[String], o:[String], do:String) -> (Int,[String],[String]) {
    var el = e
    var op = o
     var r = result
     if o.contains("÷"){
        if let _index =  o.index(of: "÷"),
            let val0 = Int(e[_index]) {
            r = val0 / (Int(e[_index+1]) ?? 1)
            el = eConfig(e:e, i: _index, r:r)
            op = oConfig(o:o, i: _index)
            print("div res\(r)")
        }
    }else if o.contains("×"){
        if let _index =  o.index(of: "×"),
            let val0 = Int(e[_index]) {
            r = val0 * (Int(e[_index+1]) ?? 1)
            el = eConfig(e:e, i: _index, r:r)
            op = oConfig(o:o, i: _index)
            print("mult res\(r)")
        }
    } else if o.contains("-"){
        if let _index =  o.index(of: "-"),
            let val0 = Int(e[_index]){
            r = val0 - (Int(e[_index+1]) ?? 0)
            el = eConfig(e:e, i: _index, r:r)
            op = oConfig(o:o, i: _index)
            print("add res\(r)")
        }} else if o.contains("+"){
        if let _index =  o.index(of: "+"),
            let val0 = Int(e[_index]){
            r = val0 + (Int(e[_index+1]) ?? 0)
            el = eConfig(e:e, i: _index, r:r)
            op = oConfig(o:o, i: _index)
            print("sub res\(r)")
        }
        }
    
    return (r, el, op)
     
}
func eConfig(e:[String], i:Int, r:Int) -> [String] {
    var el = e
    print ("removing\(el[i]) & \(el[i+1])")
    el.remove(at: i)
    el.remove(at: i)
    el.insert(String(r), at: i)
    print ("retuning\(el)")
    return el
}
func oConfig(o:[String], i:Int) -> [String] {
    var op = o
    print ("removing\(op[i])")
    op.remove(at: i)
    print ("retuning\(op)")

    return op
}
