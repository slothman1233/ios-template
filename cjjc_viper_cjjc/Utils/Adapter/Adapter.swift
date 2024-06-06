//
//  Adapter.swift
//  YiDa
//
//  Created by A1 on 2022/8/8.
//

import Foundation
import UIKit

public class SizeAdapter
{
    
    static private var _rate:CGFloat = 1
    static private var _wrate:CGFloat = 1
    static private var _hrate:CGFloat = 1
    

    /// 指定UI设计原型图所用的设备尺寸。请在- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions方法的开始处调用这个方法，比如当UI设计人员用iPhone6作为界面的原型尺寸则将size设置为375,667。
    ///
    /// - Parameter size: 模板的尺寸
    public class func template(_ size:CGSize)
    {
        let screenSize = UIScreen.main.bounds.size;
        
        _wrate = screenSize.width / size.width;
        _hrate = screenSize.height / size.height;
        _rate = sqrt((screenSize.width * screenSize.width + screenSize.height * screenSize.height) / (size.width * size.width + size.height * size.height));

    }

    

    /// 返回屏幕尺寸缩放的比例
    ///
    /// - Parameter val: 要计算的值
    /// - Returns: 按比例缩放的值
    public class func size(_ val:CGFloat) ->CGFloat
    {
        return _tgRoundNumber(val * _rate)
    }
    
    
    /**
     返回屏幕宽度缩放的比例
     */
    public class func width(_ val:CGFloat) ->CGFloat
    {
        return _tgRoundNumber(val * _wrate)
    }
    
    /**
     返回屏幕高度缩放的比例
     */
    public class func height(_ val:CGFloat) ->CGFloat
    {
        return _tgRoundNumber(val * _hrate)
    }
    
    /**
     根据屏幕清晰度将带小数的入参返回能转化为有效物理像素的最接近的设备点值。
     比如当入参为1.3时，那么在1倍屏幕下的有效值就是1,而在2倍屏幕下的有效值就是1.5,而在3倍屏幕下的有效值就是1.3333333了
     */
    public class func round(_ val:CGFloat) ->CGFloat
    {
        return _tgRoundNumber(val)
    }
    
    /**
     根据屏幕清晰度将带小数的point入参返回能转化为有效物理像素的最接近的设备point点值。
     */
    public class func round(_ val:CGPoint) ->CGPoint
    {
        return _tgRoundPoint(val)
    }
    
    /**
     根据屏幕清晰度将带小数的size入参返回能转化为有效物理像素的最接近的设备size点值。
     */
    public class func round(_ val:CGSize) ->CGSize
    {
        return _tgRoundSize(val)
    }
    
    /**
     根据屏幕清晰度将带小数的rect入参返回能转化为有效物理像素的最接近的设备rect点值。
     */
    public class func round(_ val:CGRect) ->CGRect
    {
        return _tgRoundRect(val)
    }
}

extension Float {
    
    var w: Float {
        get {
            return Float(SizeAdapter.width(CGFloat(self)))
        }
    }
    
    var h: Float {
        get {
            return Float(SizeAdapter.height(CGFloat(self)))
        }
    }
    
    var s: Float {
        get {
            return Float(SizeAdapter.size(CGFloat(self)))
        }
    }
    
}

extension Int {
    
    var w: Int {
        get {
            return Int(SizeAdapter.width(CGFloat(self)))
        }
    }
    
    var h: Int {
        get {
            return Int(SizeAdapter.height(CGFloat(self)))
        }
    }
    
    var s: Int {
        get {
            return Int(SizeAdapter.size(CGFloat(self)))
        }
    }
}

extension Double {
    
    var w: Double {
        get {
            return Double(SizeAdapter.width(CGFloat(self)))
        }
    }
    
    var h: Double {
        get {
            return Double(SizeAdapter.height(CGFloat(self)))
        }
    }
    
    var s: Double {
        get {
            return Double(SizeAdapter.size(CGFloat(self)))
        }
    }
}

let _tgrScale = UIScreen.main.scale
let _tgrSizeError = 1.0 / _tgrScale + 0.0001

internal func _tgRoundNumber(_ f :CGFloat) ->CGFloat
{
    guard f != 0 && f != CGFloat.greatestFiniteMagnitude && f != -CGFloat.greatestFiniteMagnitude  else
    {
        return f
    }
    
    
    //按精度四舍五入
    //正确的算法应该是。x = 0; y = 0;  0<x<0.5 y = 0;   x = 0.5 y = 0.5;  0.5<x<1 y = 0.5; x=1 y = 1;
    
    if (f < 0)
    {
        return ceil(fma(f, _tgrScale, -0.5)) / _tgrScale
    }
    else
    {
        return floor(fma(f, _tgrScale, 0.5)) / _tgrScale
    }
    
}

internal func _tgRoundRectForLayout(_ rect:CGRect) ->CGRect
{
    let  x1 = rect.origin.x
    let  y1 = rect.origin.y
    let  w1 = rect.size.width
    let  h1 = rect.size.height
    
    var rect = rect
    
    rect.origin.x =  _tgRoundNumber(x1)
    rect.origin.y = _tgRoundNumber(y1)
    
    let mx = _tgRoundNumber(x1 + w1)
    let my = _tgRoundNumber(y1 + h1)
    
    rect.size.width = mx - rect.origin.x
    rect.size.height = my - rect.origin.y
    
    return rect;

}

internal func _tgRoundRect(_ rect:CGRect) ->CGRect
{
    var rect = rect
    
    rect.origin.x = _tgRoundNumber(rect.origin.x)
    rect.origin.y = _tgRoundNumber(rect.origin.y)
    rect.size.width = _tgRoundNumber(rect.size.width)
    rect.size.height = _tgRoundNumber(rect.size.height)
    
    return rect
}

internal func _tgRoundSize(_ size:CGSize) ->CGSize
{
    var size = size
    size.width = _tgRoundNumber(size.width)
    size.height = _tgRoundNumber(size.height)
    return size
}

internal func _tgRoundPoint(_ point:CGPoint) ->CGPoint
{
    var point = point
    point.x = _tgRoundNumber(point.x)
    point.y = _tgRoundNumber(point.y)
    
    return point
}
