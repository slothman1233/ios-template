//
//  HLRegularTool.swift
//  hailiao
//
//  Created by lol on 2017/6/19.
//  Copyright © 2017年 hailiao. All rights reserved.
//

import UIKit
import Foundation

class Tools: NSObject {
    
    
    /** *********** 时间差计算 *********** */
    class func getHHMMSSFormSS(create_time:String,end_time:String) -> [String:String] {
        let timeSta:TimeInterval = TimeInterval(Double(end_time)! / 1000)
        let date = NSDate.init(timeIntervalSince1970: timeSta)
        
        let timeSta1:TimeInterval = TimeInterval(Double(create_time)! / 1000)
        let date1 = NSDate.init(timeIntervalSince1970: timeSta1)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let timeNumber = Int(date.timeIntervalSince1970-date1.timeIntervalSince1970)
        
        
        let str_hour = String.init(format: "%02ld", timeNumber/3600%24)
        let str_minute = String.init(format: "%02ld", (timeNumber%3600)/60)
        let str_second = String.init(format: "%02ld", timeNumber%60)
        let day = String.init(format: "%01ld", timeNumber/3600/24)
        let time = String.init(format: "%@:%@:%@:%@",day,str_hour,str_minute,str_second)
        
        let dic = ["day":day,
                   "hour":str_hour,
                   "minute":str_minute,
                   "second":str_second,
                   "time":time,]
        
        return dic
    }
    class func getMessageDateStringFromTimeInterval(time:TimeInterval,needTime:Bool) -> String{
        let times = time/1000
        let messageDate = Date(timeIntervalSince1970: times)
        
        let formatter = DateFormatter()
        formatter.locale = NSLocale.system
        formatter.timeZone = NSTimeZone.system
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let cal = Calendar.current
        var components = cal.dateComponents([.era, .year, .month, .day, .weekday], from: messageDate)
        let msgDate = cal.date(from: components)
        
        let weekday = getWeekdayWithNumber(num: components.weekday ?? 1)
        
        components = cal.dateComponents([.era, .year, .month, .day, .weekday], from: Date.init())
        
        let today = cal.date(from: components)
        
        if today == msgDate {
            if needTime == true {
                formatter.dateFormat = "HH:mm"
            }else{
                formatter.dateFormat = "今天"
            }
            return formatter.string(from: messageDate)
        }
        
        var day = components.day!
        day -= 1
        components.day = day
        
        let yestoday = cal.date(from: components)
        if yestoday == msgDate {
            if needTime == true {
                formatter.dateFormat = "昨天 HH:mm"
            }else{
                formatter.dateFormat = "昨天"
            }
            return formatter.string(from: messageDate)
        }
        
        for _ in 0..<5 {
            day -= 1
            components.day = day
            let nowdate = cal.date(from: components)
            if nowdate == msgDate {
                if needTime == true {
                    formatter.dateFormat = "\(weekday) HH:mm"
                }else{
                    formatter.dateFormat = weekday
                }
                return formatter.string(from: messageDate)
            }
        }
        
        while true {
            day -= 1
            components.day = day
            let nowdate = cal.date(from: components)
            if nowdate == msgDate {
                if needTime == false {
                    formatter.dateFormat = "YYYY/MM/dd"
                }
                return formatter.string(from: messageDate)
            }
        }
    }
    
    class func getWeekdayWithNumber(num:Int) -> String {
        switch num {
        case 1:
            return "星期日"
        case 2:
            return "星期一"
        case 3:
            return "星期二"
        case 4:
            return "星期三"
        case 5:
            return "星期四"
        case 6:
            return "星期五"
        case 7:
            return "星期六"
        default:
            return ""
        }
    }
    class func dayDifference(from interval : TimeInterval) -> String{
        let calendar = NSCalendar.current
        let date = Date(timeIntervalSince1970: interval)
        if calendar.isDateInYesterday(date) { return "昨天" }
        else if calendar.isDateInToday(date) { return "今天" }
        else if calendar.isDateInTomorrow(date) { return "Tomorrow" }
        else {
            let startOfNow = calendar.startOfDay(for: Date())
            let startOfTimeStamp = calendar.startOfDay(for: date)
            let components = calendar.dateComponents([.day], from: startOfNow, to: startOfTimeStamp)
            let day = components.day!
            if day < 1 { return "\(abs(day)) days ago" }
            else { return "In \(day) days" }
        }
    }
    class func getCurrentTime() -> String {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"//设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
        
        let locationString = dateFormatter.string(from: Date())
        
        let timeSam = Int(Date().timeIntervalSince1970)
        
        let str_hour = NSString(format: "%02ld", timeSam/3600%24)
        let str_minute = NSString(format: "%02ld", (timeSam%3600)/60)
        let str_second = NSString(format: "%02ld", timeSam%60)
        let day = NSString(format: "%01ld", timeSam/3600/24)
        let time = NSString(format: "%@:%@:%@:%@",day,str_hour,str_minute,str_second)
        pLog( time)
        
        return locationString
    }
    class func getTimes() -> String {
        var str = ""
        var timers: [Int] = [] //  返回的数组
        
        let calendar: Calendar = Calendar(identifier: .gregorian)
        var comps: DateComponents = DateComponents()
        comps = calendar.dateComponents([.year,.month,.day, .weekday, .hour, .minute,.second], from: Date())
        
        timers.append(comps.year! % 2000)  // 年 ，后2位数
        timers.append(comps.month!)            // 月
        timers.append(comps.day!)                // 日
        timers.append(comps.hour!)               // 小时
        timers.append(comps.minute!)            // 分钟
        timers.append(comps.second!)            // 秒
        timers.append(comps.weekday! - 1)      //星期
        
        if comps.hour! >= 6 && comps.hour! <= 12 {
            str = "上午好"
        }
        else if comps.hour! > 12 && comps.hour! <= 18 {
            str = "下午好"
        }else{
            str = "晚上好"
        }
        return str
    }
}

/** *********** 屏幕宽度 *********** */
let Screen_Width = UIScreen.main.bounds.size.width
/** *********** 屏幕宽高度 *********** */
let Screen_Height = UIScreen.main.bounds.size.height
/** *********** 屏幕倍数 *********** */
let Screen_Scale = UIScreen.main.scale
/** *********** 状态栏高度 *********** */
let kStatusBarHeight = UIApplication.shared.keyWindows.windowScene?.statusBarManager?.statusBarFrame.size.height ?? 0
/** *********** 导航栏高度 *********** */
let kNavBarHeight:CGFloat = 44
/** *********** tabbar高度 *********** */
let kTabBarHeight:CGFloat = kStatusBarHeight>20 ? 83 : 49
/** *********** 头部高度 *********** */
let kTopHeight = kStatusBarHeight + kNavBarHeight
/** *********** 底部手势区域高度 *********** */
let kBlankHeight:CGFloat = kStatusBarHeight>20 ? 34 : 0
/** *********** x 专用 *********** */
let kHeadHeight:CGFloat = kStatusBarHeight>20 ? 20 : 0
/** *********** x 横屏专用 *********** */
let kHeadCrossHeight:CGFloat = kStatusBarHeight==0 ? 30 : 0

/** *********** 错误提示 *********** */
let errorStr : String? = nil

/** *********** toplb *********** */
let topLbHeight:CGFloat = 40

/** *********** toplb *********** */
let topHeight:CGFloat = kTopHeight + topLbHeight

/** ***********  *********** */
let proportion:CGFloat = Screen_Width*0.3

/** *********** 获取图片 *********** */
func ImageWithName(_ img:String) -> UIImage?{
    return UIImage.init(named: img)
}
// 设置pickerView的高度
public var klPickerViewHeight: CGFloat {
    return 216
}
// 高度比列
public func kl_scaleHeight(h: CGFloat)->CGFloat {
    return Screen_Height/667*h
}
// 宽度比
public func kl_scaleWidth(w: CGFloat)->CGFloat {
    return Screen_Width/375*w
}

func Radom() -> Int{
    return Int(arc4random() % 899999 + 100000)
}
/** *********** 语言 *********** */
func Language(_ key:String) -> String{
    return key.localized()
}
/** *********** font设置 *********** */
func Font(_ font:CGFloat) -> UIFont{
    return UIFont.systemFont(ofSize: font)
}
/** *********** font粗体设置 *********** */
func FontBold(_ font:CGFloat) -> UIFont{
    return UIFont.boldSystemFont(ofSize: font)
}
/** *********** hex颜色 *********** */
func Hex(_ color:String) -> UIColor {
    return UIColor.init(hexString: color)
}
/** *********** hex颜色 *********** */
func Hex(_ color:String,_ alpha:CGFloat) -> UIColor {
    return UIColor.init(hexString: color).withAlphaComponent(alpha)
}
/** *********** rgb颜色 *********** */
func RGB(_ r:CGFloat,_ g:CGFloat,_ b:CGFloat) -> UIColor {
    return UIColor.init(r: r, g: g, b: b)
}
/** *********** rgb Alpha颜色 *********** */
func RGB(_ r:CGFloat,_ g:CGFloat,_ b:CGFloat,_ a:CGFloat) -> UIColor {
    return UIColor.init(r: r, g: g, b: b, alpha: a)
}


func pLog(_ items: Any?...,
    separator: String = " ",
    terminator: String = "\n",
    file: String = #file,
    line: Int = #line,
    time : String = Date.init().milliStamp.timeStamp2,
    method: String = #function)
{
    #if DEBUG
    if items.count == 1 {
        print("\(time) [\((file as NSString).lastPathComponent).\(line)]---> \(items[0] ?? "")\n")
    }else{
        print("\(time) [\((file as NSString).lastPathComponent).\(line)]")
        for a in items {
            print("\(a ?? "")")
        }
        print("")
    }
    #endif
}
