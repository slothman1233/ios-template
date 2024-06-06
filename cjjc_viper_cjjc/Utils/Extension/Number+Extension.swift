//
//  FloatExtension.swift
//  Example
//
//  Created by apple on 2020/7/22.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit


extension Float {
    /* *********** 精度 *********** */
    var decimal : String{
        let doulbeString:String = String.init(format: "\(self)")
        let dec:Decimal = Decimal.init(string: doulbeString)!
        return String.init(format: "%@", dec as CVarArg)
    }
    /* *********** 时间戳转时间 *********** */
    var timeStamp : String {
        let timeSta:TimeInterval = TimeInterval(Double(self) / 1000)
        let date = Date.init(timeIntervalSince1970: timeSta)
        let dfmatter = DateFormatter()
        //yyyy-MM-dd HH:mm:ss
        dfmatter.dateFormat="yyyy-MM-dd HH:mm"
        return dfmatter.string(from: date)
    }
    var string : String {
        return String(format: "%@", NSNumber.init(value: self))
    }
    /* *********** 取出多余的0 *********** */
    var num : String{
        let out = String(format: "%@", NSNumber.init(value: self))
        return out
    }
    var cgFloat: CGFloat {
        return CGFloat(self)
    }
}
//MARK: - CGFloat 浮点型

extension CGFloat {
    var intValue: Int {
        return Int(self)
    }
    
    var font: UIFont {
        return UIFont.systemFont(ofSize: self)
    }
    
    var fontBold: UIFont {
        return UIFont.boldSystemFont(ofSize: self)
    }
    
    var fontMedium: UIFont {
        return UIFont.systemFont(ofSize: self, weight: .medium)
    }
    
    var fontHeavy: UIFont {
        return UIFont.systemFont(ofSize: self, weight: .heavy)
    }
}

//MARK: - Int 整型

extension Int {
    var cgFloat: CGFloat {
        return CGFloat(self)
    }
    var double: Double {
        return Double(self)
    }
    var timeStamp : String {
        let timeSta:TimeInterval = TimeInterval(self / 1000)
        let date = Date.init(timeIntervalSince1970: timeSta)
        let dfmatter = DateFormatter()
        //yyyy-MM-dd HH:mm:ss
        dfmatter.dateFormat="yyyy-MM-dd HH:mm"
        return dfmatter.string(from: date)
    }
    var string : String {
        return String.init(format: "%d", self)
    }
   
    var font: UIFont {
        return UIFont.systemFont(ofSize: self.cgFloat)
    }
    
    var fontBold: UIFont {
        return UIFont.boldSystemFont(ofSize: self.cgFloat)
    }
    
    var fontMedium: UIFont {
        return UIFont.systemFont(ofSize: self.cgFloat, weight: .medium)
    }
    
    var fontHeavy: UIFont {
        return UIFont.systemFont(ofSize: self.cgFloat, weight: .heavy)
    }
}

extension Double {
    var decimal : String{
        let doulbeString:String = String.init(format: "\(self)")
        let dec:Decimal = Decimal.init(string: doulbeString)!
        return String.init(format: "%@", dec as CVarArg)
    }
    var timeStamp : String {
        let timeSta:TimeInterval = TimeInterval(self / 1000)
        let date = Date.init(timeIntervalSince1970: timeSta)
        let dfmatter = DateFormatter()
        //yyyy-MM-dd HH:mm:ss
        dfmatter.dateFormat="yyyy-MM-dd HH:mm"
        return dfmatter.string(from: date)
    }
    var string : String {
        return String(format: "%@", NSNumber.init(value: self))
    }
    /* *********** 取出多余的0 *********** */
    var num : String{
        let out = String(format: "%@", NSNumber.init(value: self))
        return out
    }
    /// Rounds the double to decimal places value
    
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    var cgFloat: CGFloat {
        return CGFloat(self)
    }
}

