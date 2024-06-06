//
//  UIViewExtension.swift
//  hailiao
//
//  Created by lol on 2017/5/3.
//  Copyright © 2017年 hailiao. All rights reserved.
//

import Foundation

/// 抖动方向枚举
public enum ShakeDirection {
    /// 水平抖动
    case horizontal
    /// 垂直抖动
    case vertical
}

extension UIView {
    /// 扩展UIView增加抖动方法
    ///
    /// - Parameters:
    ///   - direction: 抖动方向（默认是水平方向）
    ///   - times: 抖动次数（默认6次）
    ///   - interval: 每次抖动时间（默认0.1秒）
    ///   - delta: 抖动偏移量（默认4）
    ///   - completion: 抖动动画结束后的回调
    public func shake(direction: ShakeDirection = .horizontal, times: Int = 6, interval: TimeInterval = 0.1, delta: CGFloat = 4, completion: ((Bool) -> ())? = nil) {
        
        UIView.animate(withDuration: interval, animations: {
            switch direction {
            case .horizontal:
                self.layer.setAffineTransform(CGAffineTransform(translationX: delta, y: 0))
            case .vertical:
                self.layer.setAffineTransform(CGAffineTransform(translationX: 0, y: delta))
            }
            
        }) { (_) in
            
            if (times == 0) { // 最后一次抖动，将位置还原，并调用完成回调函数
                UIView.animate(withDuration: interval, animations: {
                    self.layer.setAffineTransform(CGAffineTransform.identity)
                }, completion: completion)
            } else { // 不是最后一次抖动，继续播放动画（总次数减1，偏移位置反向）
                self.shake(direction: direction, times: times - 1,  interval: interval, delta: delta * -1, completion:completion)
            }
        }
    }
}


enum UIBorderSideType: Int {
    case All
    case Top
    case Bottom
    case Left
    case Right
    case LeftTop
    case LeftBottom
    case RightTop
    case RightBottom
}

extension UIView {
    func removeSubviews(){
        for v in self.subviews {
            v.removeFromSuperview()
        }
    }
    
    func add(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }
    
    //圆角
    func round(cornerRadius:CGFloat)  {
         self.round(cornerRadius: cornerRadius, width: 0, borderColor: UIColor.white)
    }
   
    //border
    func borderAll(borderWidth:CGFloat,color:UIColor)  {
        self.round(cornerRadius: 0, width: borderWidth, borderColor: color)
    }
    
    func round(cornerRadius:CGFloat,width:CGFloat,borderColor:UIColor) {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = width
        layer.borderColor = borderColor.cgColor
        layer.masksToBounds = true
    }
    //设置
    func border(color: UIColor,borderWidth:CGFloat,borderType:UIBorderSideType,scale:CGFloat){
        let wid = frame.size.width*scale/2
        let hei = frame.size.height*scale/2
        if borderType == .All {
            layer.borderWidth = borderWidth
            layer.borderColor = color.cgColor
        }
        if borderType == .Left {
            layer .addSublayer(addLine(point0: CGPoint.init(x: 0, y: hei), point1: CGPoint.init(x: 0, y: frame.size.height-hei), color: color, borderWidth: borderWidth))
        }
        if borderType == .Right {
            layer.addSublayer(addLine(point0: CGPoint.init(x: frame.size.width, y: hei), point1: CGPoint.init(x: frame.size.width, y: frame.size.height-hei), color: color, borderWidth: borderWidth))
        }
        if borderType == .Top {
            layer.addSublayer(addLine(point0: CGPoint.init(x: wid, y: 0), point1: CGPoint.init(x: frame.size.width-wid, y: 0), color: color, borderWidth: borderWidth))
        }
        if borderType == .Bottom {
            layer.addSublayer(addLine(point0: CGPoint.init(x: wid, y: frame.size.height), point1: CGPoint.init(x: frame.size.width-wid, y: frame.size.height), color: color, borderWidth: borderWidth))
        }
        if borderType == .LeftTop {
            layer.addSublayer(addLine(point0: CGPoint.init(x: 0, y: frame.size.height), point1: CGPoint.init(x: 0, y: 0), point2: CGPoint.init(x: frame.size.width, y: 0), color: color, borderWidth: borderWidth))
        }
        if borderType == .LeftBottom {
            layer.addSublayer(addLine(point0: CGPoint.init(x: 0, y: 0), point1: CGPoint.init(x: 0, y: frame.size.height), point2: CGPoint.init(x: frame.size.width, y: frame.size.height), color: color, borderWidth: borderWidth))
        }
        if borderType == .RightTop {
            layer.addSublayer(addLine(point0: CGPoint.init(x: 0, y: 0), point1: CGPoint.init(x: frame.size.width, y: 0), point2: CGPoint.init(x: frame.size.width, y: frame.size.height), color: color, borderWidth: borderWidth))
        }
        if borderType == .RightBottom {
            layer.addSublayer(addLine(point0: CGPoint.init(x: 0, y: frame.size.height), point1: CGPoint.init(x: frame.size.width, y: frame.size.height), point2: CGPoint.init(x: frame.size.width, y: 0), color: color, borderWidth: borderWidth))
        }
    }
    //划折线
    func addLine(point0:CGPoint,point1:CGPoint,point2:CGPoint,color:UIColor,borderWidth:CGFloat) -> CAShapeLayer{
        let bezierPath = UIBezierPath.init()
        bezierPath.move(to: point0)
        bezierPath.addLine(to: point1)
        bezierPath.addLine(to: point2)
        
        let shapeLayer = CAShapeLayer.init()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.path = bezierPath.cgPath
        shapeLayer.lineCap = .round
        shapeLayer.lineJoin = .round
        shapeLayer.lineWidth = borderWidth
        return shapeLayer
    }
    //划直线
    func addLine(point0:CGPoint,point1:CGPoint,color:UIColor,borderWidth:CGFloat) -> CAShapeLayer{
        let bezierPath = UIBezierPath.init()
        bezierPath.move(to: point0)
        bezierPath.addLine(to: point1)
        
        let shapeLayer = CAShapeLayer.init()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.path = bezierPath.cgPath
        shapeLayer.lineCap = .round
        shapeLayer.lineJoin = .round
        shapeLayer.lineWidth = borderWidth
        return shapeLayer
    }
   //shadow
    func shadow(shadowColer:UIColor,opacity:Float,radius:CGFloat,offset:CGSize) {
        layer.masksToBounds = false
        layer.shadowColor = shadowColer.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = offset
        layer.cornerRadius = radius
    }
    //设置部分圆角
    func setRoundCorners(corners:UIRectCorner,with radii:CGFloat){
        let bezierpath:UIBezierPath = UIBezierPath.init(roundedRect: (self.bounds), byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let shape:CAShapeLayer = CAShapeLayer.init()
        shape.path = bezierpath.cgPath
        shape.lineWidth = 1
//        shape.lineCap = CAShapeLayerLineCap.square
        shape.strokeColor = UIColor.red.cgColor
//        self.layer.mask = shape
        self.layer.addSublayer(shape)
        
    }
    // 切部分方向的圆角
    func cutFillet(rectCornerType: UIRectCorner, cornerRadii: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: rectCornerType, cornerRadii: CGSize(width: cornerRadii, height: cornerRadii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    func cutFilletAll(_ cornerRadius: CGFloat) {

        let maskPath = UIBezierPath.init(roundedRect: self.bounds, cornerRadius: cornerRadius)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    //添加4个不同大小的圆角
    func corner(topLeft:CGFloat = 0,topRight:CGFloat = 0, bottomLeft:CGFloat = 0,  bottomRight:CGFloat = 0){
        let path = createPathWithRoundedRect(bounds: self.bounds, cornerRadii:CornerRadii.init(topLeft: topLeft, topRight: topRight, bottomLeft: bottomLeft, bottomRight: bottomRight))
        let shapLayer = CAShapeLayer()
        shapLayer.frame = self.bounds
        shapLayer.path = path
        self.layer.mask = shapLayer
//        self.layer.addSublayer(shapLayer)
    }
    //各圆角大小
    struct CornerRadii {
        var topLeft :CGFloat = 0
        var topRight :CGFloat = 0
        var bottomLeft :CGFloat = 0
        var bottomRight :CGFloat = 0
    }
    //切圆角函数绘制线条
    func createPathWithRoundedRect( bounds:CGRect,cornerRadii:CornerRadii) -> CGPath
    {
        let minX = bounds.minX
        let minY = bounds.minY
        let maxX = bounds.maxX
        let maxY = bounds.maxY
        
        //获取四个圆心
        let topLeftCenterX = minX +  cornerRadii.topLeft
        let topLeftCenterY = minY + cornerRadii.topLeft
        
        let topRightCenterX = maxX - cornerRadii.topRight
        let topRightCenterY = minY + cornerRadii.topRight
        
        let bottomLeftCenterX = minX +  cornerRadii.bottomLeft
        let bottomLeftCenterY = maxY - cornerRadii.bottomLeft
        
        let bottomRightCenterX = maxX -  cornerRadii.bottomRight
        let bottomRightCenterY = maxY - cornerRadii.bottomRight
        
        //虽然顺时针参数是YES，在iOS中的UIView中，这里实际是逆时针
        let path :CGMutablePath = CGMutablePath();
        //顶 左
        path.addArc(center: CGPoint(x: topLeftCenterX, y: topLeftCenterY), radius: cornerRadii.topLeft, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 3 / 2, clockwise: false)
        
        //顶右
        path.addArc(center: CGPoint(x: topRightCenterX, y: topRightCenterY), radius: cornerRadii.topRight, startAngle: CGFloat.pi * 3 / 2, endAngle: 0, clockwise: false)
        //底右
        path.addArc(center: CGPoint(x: bottomRightCenterX, y: bottomRightCenterY), radius: cornerRadii.bottomRight, startAngle: 0, endAngle: CGFloat.pi / 2, clockwise: false)
        //底左
        path.addArc(center: CGPoint(x: bottomLeftCenterX, y: bottomLeftCenterY), radius: cornerRadii.bottomLeft, startAngle: CGFloat.pi / 2, endAngle: CGFloat.pi, clockwise: false)
        path.closeSubpath();
        return path;
    }
    
    /**
     view 获取它的控制器
     */
    public func viewController()->UIViewController? {
        
        var nextResponder: UIResponder? = self
        
        repeat {
            nextResponder = nextResponder?.next
            
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            
        } while nextResponder != nil
        
        return nil
    }
    
    // x
    @nonobjc var x : CGFloat {
        get {
            return frame.origin.x
        }
        set(newVal) {
            var tmpFrame : CGRect = frame
            tmpFrame.origin.x     = newVal
            frame                 = tmpFrame
        }
    }
    
    // y
    @nonobjc var y : CGFloat {
        get {
            return frame.origin.y
        }
        set(newVal) {
            var tmpFrame : CGRect = frame
            tmpFrame.origin.y     = newVal
            frame                 = tmpFrame
        }
    }
    
    // height
    @nonobjc var height : CGFloat {
        get {
            return frame.size.height
        }
        set(newVal) {
            var tmpFrame : CGRect = frame
            tmpFrame.size.height  = newVal
            frame                 = tmpFrame
        }
    }
    
    // width
    @nonobjc var width : CGFloat {
        get {
            return frame.size.width
        }
        set(newVal) {
            var tmpFrame : CGRect = frame
            tmpFrame.size.width   = newVal
            frame                 = tmpFrame
        }
    }
    
    // left
    @nonobjc var left : CGFloat {
        get {
            return x
        }
        set(newVal) {
            x = newVal
        }
    }
    
    // right
    @nonobjc var right : CGFloat {
        get {
            return x + width
        }
        set(newVal) {
            x = newVal - width
        }
    }
    
    // top
    @nonobjc var top : CGFloat {
        get {
            return y
        }
        set(newVal) {
            y = newVal
        }
    }
    
    // bottom
    @nonobjc var bottom : CGFloat {
        get {
            return y + height
        }
        set(newVal) {
            y = newVal - height
        }
    }
    
    @nonobjc var centerX : CGFloat {
        get {
            return center.x
        }
        
        set(newVal) {
            center = CGPoint(x: newVal, y: center.y)
        }
    }
    
    @nonobjc var centerY : CGFloat {
        get {
            return center.y
        }
        set(newVal) {
            center = CGPoint(x: center.x, y: newVal)
        }
    }
    
    @nonobjc var middleX : CGFloat {
        get {
            return width / 2
        }
    }
    
    @nonobjc var middleY : CGFloat {
        get {
            return height / 2
        }
    }
    
    @nonobjc var middlePoint : CGPoint {
        get {
            return CGPoint(x: middleX, y: middleY)
        }
    }
    
    @nonobjc var size : CGSize {
        get {
            return frame.size
        }
        set(newVal) {
            frame.size = newVal
        }
    }
    
    @nonobjc var origin : CGPoint {
        get {
            return frame.origin
        }
        set(newVal) {
            frame.origin = newVal
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
        
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            return layer.borderColor != nil ? UIColor(cgColor: layer.borderColor!) : nil
        }
    }
}
extension UIView {
    // UIView截图
    func snapshot() -> UIImage {
        // 1.开启上下文
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0.0)
        
        // 2.将控制器view的layer渲染到上下文
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        // 3.取出图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        // 4.结束上下文
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func screenShot() -> UIImage{
        return screenShot(rect: bounds)
    }
    
    func screenShot(rect : CGRect) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        
        guard let content = UIGraphicsGetCurrentContext() else {
            return UIImage()
        }
        
        let path = UIBezierPath(rect: rect)
        path.addClip()
        
        layer.render(in: content)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()

        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        
        image!.draw(at: CGPoint(x: -rect.origin.x, y: -rect.origin.y))
        
        let image2 = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image2!
    }
}
