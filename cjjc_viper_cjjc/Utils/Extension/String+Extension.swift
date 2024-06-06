//
//  StringExtension.swift
//  hailiao
//
//  Created by lol on 2017/5/3.
//  Copyright © 2017年 hailiao. All rights reserved.
//

import Foundation
import CommonCrypto
import UIKit
import CryptoSwift

extension String {
    /** *********** 生成二维码 *********** */
    func codeImg(_ size:CGFloat) -> UIImage?{
        let filter = CIFilter(name:"CIQRCodeGenerator")
        filter?.setDefaults()
        
        filter?.setValue(self.data(using: String.Encoding.utf8), forKey: "InputMessage")
        
        let ciimage:CIImage = (filter?.outputImage)!
        
        let extent: CGRect = ciimage.extent.integral
        let scale: CGFloat = min(size/extent.width, size/extent.height)
        
        
        let width = extent.width * scale
        let height = extent.height * scale
        let cs: CGColorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapRef = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: cs, bitmapInfo: 0)!
        
        let context = CIContext(options: nil)
        let bitmapImage: CGImage = context.createCGImage(ciimage, from: extent)!
        
        bitmapRef.interpolationQuality = CGInterpolationQuality.none
        bitmapRef.scaleBy(x: scale, y: scale);
        bitmapRef.draw(bitmapImage, in: extent)
        
        let scaledImage: CGImage = bitmapRef.makeImage()!
        
        return UIImage(cgImage: scaledImage)
    }
    // 手机号脱敏
    var phoneDesensitization : String?{
        if self.count == 11 {
            var str = self
            str.replaceSubrange(str.index(str.startIndex, offsetBy: 3)..<str.index(str.endIndex, offsetBy: -4), with: "****")
            return str
        }
        return self
    }
    var image : UIImage?{
        return UIImage.init(named: self)
    }
    var Hex : UIColor{
        return UIColor.init(hexString: self)
    }
    func Hex(_ alpha : CGFloat) -> UIColor{
        return UIColor.init(hexString: self).withAlphaComponent(alpha)
    }
    var dic : [String : Any]?{
        let data = self.data(using: String.Encoding.utf8)
        if let dict = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any] {
            return dict
        }
        return nil
    }
    var timeStamp : String {
        let timeSta:TimeInterval = TimeInterval(Double(self)! / 1000)
        let date = Date.init(timeIntervalSince1970: timeSta)
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy-MM-dd HH:mm"
        return dfmatter.string(from: date )
    }
    var timeStamp1 : String {
        let timeSta:TimeInterval = TimeInterval(Double(self)! / 1000)
        let date = Date.init(timeIntervalSince1970: timeSta)
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy-MM-dd HH:mm:ss"
        return dfmatter.string(from: date)
    }
    /** **********  打印器专用  *********** */
    var timeStamp2 : String {
        let timeSta:TimeInterval = TimeInterval(Double(self)! / 1000)
        let date = Date.init(timeIntervalSince1970: timeSta)
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy-MM-dd HH:mm:ss.SSS"
        return dfmatter.string(from: date)
    }
    var float : Float {
        return Float.init(Float(self) ?? 0)
    }
    var double : Double {
        return Double.init(Double(self) ?? 0)
    }
    var int : Int {
        return Int.init(Int(self) ?? 0)
    }
    var bool : Bool {
        return Bool.init(Bool(self) ?? false)
    }
    var cgFloat: CGFloat {
        return CGFloat(self.float)
    }
    // MARK: -  md5
//    var md5 : String{
//        let str = self.cString(using: String.Encoding.utf8)
//        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
//        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
//        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
//
//        CC_MD5(str!, strLen, result)
//
//        let hash = NSMutableString()
//        for i in 0 ..< digestLen {
//            hash.appendFormat("%02x", result[i])
//        }
//        //        result.deinitialize()
//        //        pLog("1asdf".md5.suffix(16),"1asdf".prefix(2))
//        return String(format: hash as String)
//    }
    /// aes加密
    /// - Parameters:
    ///   - is256: 是否是256加密
    ///   - key: 秘钥
    /// - Returns: 加密串
    func aesEndcode(is256:Bool = true,key:String? = "NHIApTpG0nTXuzH1") -> String {
        var encodeString = ""
        do{
            var aes: AES!
            if is256 {
                aes = try AES(key: Array(key!.utf8),blockMode: ECB(),padding: .pkcs7)
            }else{
                aes = try AES(key: Padding.zeroPadding.add(to: key!.bytes, blockSize: AES.blockSize),blockMode: ECB())
            }
            let encoded = try aes.encrypt(self.bytes)
            encodeString = encoded.toBase64()
        }catch{
            print(error.localizedDescription)
        }
        return encodeString
    }
    /// aes解密
    /// - Parameters:
    ///   - is256: 是否是256加密
    ///   - key: 秘钥
    /// - Returns: 解密串
    func aesDecode(is256:Bool = true,key:String? = "NHIApTpG0nTXuzH1") -> String {
        var decodeStr = ""
        let data = NSData(base64Encoded: self, options: NSData.Base64DecodingOptions.init(rawValue: 0))
        var encrypted: [UInt8] = []
        let count = data?.length
        for i in 0..<count! {
            var temp:UInt8 = 0
            data?.getBytes(&temp, range: NSRange(location: i,length:1 ))
            encrypted.append(temp)
        }
        do {
            var aes: AES!
            if is256 {
                aes = try AES(key: Array(key!.utf8),blockMode: ECB(),padding: .pkcs7)
            }else{
                aes = try AES(key: Padding.zeroPadding.add(to: key!.bytes, blockSize: AES.blockSize),blockMode: ECB())
            }
            let decode = try aes.decrypt(encrypted)
            let encoded = Data(decode)
            decodeStr = String(bytes: encoded.bytes, encoding: .utf8)!
        }catch{
            print(error.localizedDescription)
        }
        return decodeStr
    }
    var language : String{
        return Language(self)
    }
    
    // 计算文字尺寸
    func sizeWithFont(_ maxSize: CGSize, font: UIFont) -> CGSize {
        return NSString(string: self).boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [
            NSAttributedString.Key.font : font
        ], context: nil).size
    }
    
    //计算文字宽度
    func ga_widthForComment(fontSize: CGFloat, height: CGFloat = 15) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.width)
    }
    
    //计算文字高度
    func ga_heightForComment(fontSize: CGFloat, width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height)
    }
    func ga_heightForComment1(font: UIFont, width: CGFloat) -> CGFloat {
        
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height)
    }
    func ga_heightForComment(fontSize: CGFloat, width: CGFloat, maxHeight: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height)>maxHeight ? maxHeight : ceil(rect.height)
    }
    
    /** **********  根据正则表达式改变数字文字颜色  *********** */
    func changeNum(color : UIColor) -> NSMutableAttributedString{
        let attributeString = NSMutableAttributedString(string: self)
        do {
            let regexExpression = try NSRegularExpression(pattern: "\\d+", options: NSRegularExpression.Options())
            let result = regexExpression.matches(in: self, options: NSRegularExpression.MatchingOptions(), range: NSMakeRange(0, self.count))
            for item in result {//NSForegroundColorAttributeName
                attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: item.range)
            }
        } catch {
            print("Failed with error: \(error)")
        }
        return attributeString
    }
    
    
    
    /** *********** 相加 *********** */
    static func calculateAdding(firstNumber : String, secondNumber: String) -> String{
        var first = firstNumber
        var second = secondNumber
        if firstNumber.isEmpty {
            first = "0"
        }
        if secondNumber.isEmpty {
            
            second = "0"
        }
        let num1 = NSDecimalNumber(string: first)
        let num2 = NSDecimalNumber(string: second)
        
        let add = num1.adding(num2)
        
        return add.stringValue
    }
    /** *********** 相减 *********** */
    static func calculateMinuend(firstNumber : String, secondNumber: String) -> String{
        var first = firstNumber
        var second = secondNumber
        if firstNumber.isEmpty {
            first = "0"
        }
        if secondNumber.isEmpty {
            second = "0"
        }
        let num1 = NSDecimalNumber(string: first)
        let num2 = NSDecimalNumber(string: second)
        
        let add = num1.subtracting(num2)
        
        return add.stringValue
    }
    /** *********** 相乘 *********** */
    static func calculateMultiplying(firstNumber : String, secondNumber: String) -> String{
        var first = firstNumber
        var second = secondNumber
        if firstNumber.isEmpty {
            first = "0"
        }
        if secondNumber.isEmpty {
            second = "0"
        }
        let num1 = NSDecimalNumber(string: first)
        let num2 = NSDecimalNumber(string: second)
        let add = num1.multiplying(by: num2)
        
        return add.stringValue
    }
    /** *********** 相除 *********** */
    static func calculateDividing(firstNumber : String, secondNumber: String) -> String{
        var first = firstNumber
        var second = secondNumber
        if firstNumber.isEmpty {
            first = "0"
        }
        if secondNumber.isEmpty || secondNumber == "0"{
            second = "1"
        }
        let num1 = NSDecimalNumber(string: first)
        let num2 = NSDecimalNumber(string: second)
        let add = num1.dividing(by: num2)
        
        return add.stringValue
    }
    
    static func compare(firstNumber : String, secondNumber: String) -> ComparisonResult {
        var first = firstNumber
        var second = secondNumber
        if firstNumber.isEmpty {
            first = "0"
        }
        if secondNumber.isEmpty {
            
            second = "0"
        }
        let num1 = NSDecimalNumber(string: first)
        let num2 = NSDecimalNumber(string: second)
        
        return num1.compare(num2)
    }
}

extension String {
    enum RoundingType : UInt {
        case plain//取整
        case down//只舍不入
        case up//只入不舍
        case bankers//四舍五人
    }
    ///加
    func add(num:String?) -> String {
        let number1 = NSDecimalNumber(string: self)
        let number2 = NSDecimalNumber(string: num ?? "0")
        let summation = number1.adding(number2)
        return summation.stringValue
    }
    ///减
    func minus(num:String?) -> String {
        let number1 = NSDecimalNumber(string: self)
        let number2 = NSDecimalNumber(string: num ?? "0")
        let summation = number1.subtracting(number2)
        return summation.stringValue
    }
    /// 乘
    func multiplying(num:String?) -> String {
        let number1 = NSDecimalNumber(string: self)
        let number2 = NSDecimalNumber(string: num ?? "0")
        let summation = number1.multiplying(by: number2)
        return summation.stringValue
    }
    /// 除
    func dividing(num:String?) -> String {
        let number1 = NSDecimalNumber(string: self)
        let number2 = NSDecimalNumber(string: num ?? "1")
        let summation = number1.dividing(by:number2)
        return summation.stringValue
    }
    
    func compareTo(num: String?) -> ComparisonResult {
        let number1 = NSDecimalNumber(string: self)
        let number2 = NSDecimalNumber(string: num ?? "0")
        return number1.compare(number2)
    }
    
    /**
     num 保留几位小数 type 取舍类型
     */
    func numType(num : Int , type : RoundingType) -> String {
        /*
         enum NSRoundingMode : UInt {
         
         case RoundPlain     // Round up on a tie  貌似取整
         case RoundDown      // Always down == truncate  只舍不入
         case RoundUp        // Always up  只入不舍
         case RoundBankers   // on a tie round so last digit is even  貌似四舍五入
         }
         */
        
        // 90.7049 + 0.22 然后四舍五入
        var tp = NSDecimalNumber.RoundingMode.down
        switch type {
        case RoundingType.plain:
            tp = NSDecimalNumber.RoundingMode.plain
        case RoundingType.down:
            tp = NSDecimalNumber.RoundingMode.down
        case RoundingType.up:
            tp = NSDecimalNumber.RoundingMode.up
        case RoundingType.bankers:
            tp = NSDecimalNumber.RoundingMode.bankers
        }
        let roundUp = NSDecimalNumberHandler(roundingMode: tp, scale:Int16(num), raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: true)
        
        let discount = NSDecimalNumber(string: self)
        let subtotal = NSDecimalNumber(string: "0")
        // 加 保留 2 位小数
        let total = subtotal.adding(discount, withBehavior: roundUp).stringValue
        //        let flot = Float(total)!
        //        let str = String(format: "%.2f", flot)
        
        var mutstr = String()
        
        if total.contains(".") {
            let float = total.components(separatedBy: ".").last!;
            if float.count == Int(num) {
                mutstr .append(total);
                return mutstr
            } else {
                mutstr.append(total)
                let all = num - float.count
                for _ in 1...all {
                    mutstr += "0"
                }
                return mutstr
            }
        } else {
            mutstr.append(total)
            //            if num == 0 {
            //            } else {
            //                for _ in 1...num {
            //                    mutstr += "0"
            //                }
            //            }
            return mutstr
        }
        // 加 保留 2 位小数
    }
}

// MARK: - String 字符串
extension String {
    /** *********** 数字和字母 *********** */
    var numberOrLetter : Bool{
        let regular = "^[A-Za-z0-9]+$"
        
        let regex = NSPredicate(format: "SELF MATCHES %@", regular)
        
        return regex.evaluate(with: self)
    }
    /** *********** 是否为汉字 *********** */
    var isChineseCharacters : Bool{
        let regular = "^[\\u4E00-\\u9FA5]+"
        
        let regex = NSPredicate(format: "SELF MATCHES %@", regular)
        
        return regex.evaluate(with: self)
    }
    /**--------------------------- 是否为纯数字 ---------------------------*/
    var isNumber: Bool {
        let regular = "^[0-9]*$"
        
        let regex = NSPredicate(format: "SELF MATCHES %@", regular)
        
        return regex.evaluate(with: self)
    }
    
    
    /// 保留小数点后几位
    /// - Parameters:
    ///   - string: 原先sring
    ///   - range: range
    ///   - count: 小数点后几位
    /// - Returns:
    func point(string:String,range:NSRange,count:Int) -> Bool{
        if string.count == 0{
            return true
        }
        
        let checkStr = (self as NSString?)?.replacingCharacters(in: range, with: string)
        
        let regex = "^\\-?([1-9]\\d*|0)(\\.\\d{0,\(count)})?$"
        
        let predicte = NSPredicate(format:"SELF MATCHES %@", regex)
        
        return predicte.evaluate(with: checkStr)
    }
    
    /** *********** 是否为邮箱 *********** */
    var isEmail : Bool{
        let regular = "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$"
        
        let regex = NSPredicate(format: "SELF MATCHES %@", regular)
        
        return regex.evaluate(with: self)
    }
    /** *********** 是否为身份证 *********** */
    var isIdentityCard : Bool{
        let regular = "^(\\d{14}|\\d{17})(\\d|[xX])$"
        
        let regex = NSPredicate(format: "SELF MATCHES %@", regular)
        
        return regex.evaluate(with: self)
    }
    /** *********** 是否不含特殊字符 *********** */
    var isSpecialCharacters : Bool{
        let regular = "^[a-zA-Z0-9\\u4e00-\\u9fa5]+$"
        
        let regex = NSPredicate(format: "SELF MATCHES %@", regular)
        
        return regex.evaluate(with: self)
    }
    /** *********** 字符串是否含有超链接 *********** */
    var isUrlAddressOfRange : [(urlAddress: String, range: NSRange)]{
        let regular = "((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"
        
        var tuples = [(urlAddress: String, range: NSRange)]()
        
        do {
            let regex = try NSRegularExpression(pattern: regular, options: .caseInsensitive)
            
            let array = regex.matches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, (self as NSString).length))
            
            for item in array {
                let range = NSMakeRange(item.range.location, (self as NSString).length - item.range.location)
                
                let tuple = (urlAddress: (self as NSString).substring(with: range), range: range)
                
                tuples.append(tuple)
            }
        } catch {
            
        }
        
        return tuples
    }
    private static let clsPrex = Bundle.main.infoDictionary?["CFBundleExecutable"] as? String;
    var clsType: AnyClass? {
        if let cName = String.clsPrex {
            return NSClassFromString(cName + "." + self)
        }
        return nil
    }
    
    var isPhone: Bool {
        let regex = "^1([3-9][0-9])\\d{8}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with:self)
    }
    
//    var MD5String: String {
//        let cStrl = cString(using: String.Encoding.utf8)
//        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
//        CC_MD5(cStrl, CC_LONG(strlen(cStrl!)), buffer)
//        var md5String = ""
//        for idx in 0...15 {
//            let obcStrl = String.init(format: "%02x", buffer[idx])
//            md5String.append(obcStrl)
//        }
//        free(buffer)
//        return md5String
//    }
    
    var textPinYin: String {
        if self.count > 0 {
            let pinYin = NSMutableString(string: "\(first!)")
            
            CFStringTransform(pinYin as CFMutableString, nil, kCFStringTransformMandarinLatin, false)
            
            CFStringTransform(pinYin as CFMutableString, nil, kCFStringTransformStripCombiningMarks, false)
            return pinYin as String
        }
        return ""
    }
    var firstPinYin: String {
        if !textPinYin.isEmpty {
            return String.init(textPinYin.first!).uppercased()
        }
        return ""
    }
    
    var isPassword: Bool {
        let i = ".*[0-9]+.*"
        let a = ".*[a-z]+.*"
        let A = ".*[A-Z]+.*"
        let l = ".{6,12}"
        let iprdicate = NSPredicate(format: "SELF MATCHES %@", i)
        let apredicate = NSPredicate(format: "SELF MATCHES %@", a)
        let Apredicate = NSPredicate(format: "SELF MATCHES %@", A)
        let lpredicate = NSPredicate(format: "SELF MATCHES %@", l)
        
        let compone = NSCompoundPredicate(andPredicateWithSubpredicates: [iprdicate,apredicate,Apredicate,lpredicate])
        return compone.evaluate(with: self)
    }
    
    var isPassWordFormater: Bool {
        let i = "[0-9]"
        let a = "[a-z]"
        let A = "[A-Z]"
        
        let iprdicate = NSPredicate(format: "SELF MATCHES %@", i)
        let apredicate = NSPredicate(format: "SELF MATCHES %@", a)
        let Apredicate = NSPredicate(format: "SELF MATCHES %@", A)
        
        let compone = NSCompoundPredicate(orPredicateWithSubpredicates: [iprdicate,apredicate,Apredicate])
        for item in self {
            if !compone.evaluate(with: "\(item)") {
                return false
            }
        }
        return true
    }
    
    var data: Data {
        return data(using: String.Encoding.utf8)!
    }
    var unicodeData: Data{
        return data(using: String.Encoding.unicode)!
    }
    var encode: String {
        let otherSet = CharacterSet.init(charactersIn: "{}@!*.~<>'^’%();:@&=+$,\\/?%#[]\" ").inverted;
        let encodeStrl = addingPercentEncoding(withAllowedCharacters: otherSet)
        return encodeStrl ?? ""
    }
    var decode: String {
        return removingPercentEncoding ?? ""
    }
    
    
}

extension NSAttributedString {
    // 计算文字尺寸
    func sizeWithFont(_ maxSize: CGSize) -> CGSize {
        return self.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, context: nil).size
    }
    
}

extension String {
    
    subscript(_ indexs: ClosedRange<Int>) -> String {
        let beginIndex = index(startIndex, offsetBy: indexs.lowerBound)
        let endIndex = index(startIndex, offsetBy: indexs.upperBound)
        return String(self[beginIndex...endIndex])
    }
    
    subscript(_ indexs: Range<Int>) -> String {
        let beginIndex = index(startIndex, offsetBy: indexs.lowerBound)
        let endIndex = index(startIndex, offsetBy: indexs.upperBound)
        return String(self[beginIndex..<endIndex])
    }
    
    subscript(_ indexs: PartialRangeThrough<Int>) -> String {
        let endIndex = index(startIndex, offsetBy: indexs.upperBound)
        return String(self[startIndex...endIndex])
    }
    
    subscript(_ indexs: PartialRangeFrom<Int>) -> String {
        let beginIndex = index(startIndex, offsetBy: indexs.lowerBound)
        return String(self[beginIndex..<endIndex])
    }
    
    subscript(_ indexs: PartialRangeUpTo<Int>) -> String {
        let endIndex = index(startIndex, offsetBy: indexs.upperBound)
        return String(self[startIndex..<endIndex])
    }
}

extension String {
    
    func nameAddStar() -> String {
        
     var string = ""
        if self.count <= 2 {
            string.append(self[..<1])
            string.append("*")
            return string
        }
        else if self.count > 2 {
            string.append(self[..<1])
            for _ in 0..<self.count - 2{
                string.append("*")
            }
            
            string.append(self[(self.count-1)...])
            return string
        } else {
            return self
        }
    }
    
    func idCardAddStar() -> String {
        var string = ""
        if self.count >= 6 {
            string.append(self[..<6])
            string.append("************")
            return string
        } else {
            return self
        }
    }
    
    func bankCardAddStar() -> String {
        var string = ""
        if self.count >= 9 {
//            string.append(self[..<(self.count-4)])
            string.append("****  ****  ****  ")
            string.append(self[(self.count-4)...])
            return string
        } else {
            return self
        }
    }
    
    func bankCardLast() -> String {
        var string = ""
        if self.count >= 4 {
            string.append(self[(self.count-4)...])
            return string
        } else {
            return self
        }
    }
}
