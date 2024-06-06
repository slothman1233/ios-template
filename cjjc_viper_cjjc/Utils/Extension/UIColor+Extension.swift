//
//  ColorExtension.swift
//  hailiao
//
//  Created by STApple on 16/2/18.
//  Copyright © 2016年 hailiao. All rights reserved.
//

import UIKit

extension UIColor {
    
    /** 16进制颜色创建 */
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    /** RGB颜色创建 */
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) {
        self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: alpha)
    }
    
    /** 随机色 */
    class func random() -> UIColor {
        return UIColor(red: (CGFloat)(arc4random_uniform(255)) / 255.0, green: (CGFloat)(arc4random_uniform(255)) / 255.0, blue: (CGFloat)(arc4random_uniform(255)) / 255.0, alpha: 1.0)
    }
    /** *********** label颜色 333333 *********** */
    class var tipColor : UIColor{
        return Hex("333333")
    }
    /** *********** label颜色 *********** */
    class var lbColor : UIColor{
        return Hex("000000")
    }
    /** *********** btn背景颜色 *********** */
    class var btnBackColor : UIColor{
        return .clear
    }
    /** *********** btn文字颜色 *********** */
    class var btnColor : UIColor{
        return Hex("ffffff")
    }
    
    /** *********** btn文字颜色2 ffffff"*********** */
    class var btnColor2 : UIColor{
        return Hex("#ffffff")
    }
    /** *********** tf字体颜色 *********** */
    class var tfColor : UIColor{
        return Hex("000000")
    }
    /** *********** 占位符颜色  *********** */
    class var tfPColor : UIColor{
        return Hex("CCCCCC")
    }
}

