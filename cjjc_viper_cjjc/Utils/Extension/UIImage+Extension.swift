//
//  UIImageExtension.swift
//  hailiao
//
//  Created by lol on 2017/5/3.
//  Copyright © 2017年 hailiao. All rights reserved.
//

import Foundation

extension UIImage {
    
    enum GradientType: Int {
        
        case topToBotton//从上到小
        case LeftToRight//从左到右
        case UpleftToLowright//左上到右下
        case UprightToLowleft//右上到左下
    }
    
    @nonobjc var width: CGFloat {
        return self.size.width
    }
    @nonobjc var height: CGFloat {
        return self.size.height
    }
    class func imageWithColor(_ color: UIColor,_ size : CGSize = .init(width: 1, height: 1)) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let theImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return theImage
    }
    /** *********** 生成二维码 *********** */
    class func createQRcode(_ name:String,_ size:CGFloat) -> UIImage {
        
        // 1.创建一个滤镜
        let filter = CIFilter(name:"CIQRCodeGenerator")
        //        2.将滤镜恢复到默认状态
        filter?.setDefaults()
        //        3.为滤镜添加属性    （"函冰"即为二维码扫描出来的内容，可以根据需求进行添加）
        filter?.setValue(name.data(using: String.Encoding.utf8), forKey: "InputMessage")
        //        判断是否有图片
        let ciimage:CIImage = (filter?.outputImage)!
        //        4。将二维码赋给imageview,此时调用网上找的代码片段，由于SWift3的变化，将其稍微改动，生成清晰的二维码
        let extent: CGRect = ciimage.extent.integral
        let scale: CGFloat = min(size/extent.width, size/extent.height)
        
        // 1.创建bitmap;
        let width = extent.width * scale
        let height = extent.height * scale
        let cs: CGColorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapRef = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: cs, bitmapInfo: 0)!
        
        let context = CIContext(options: nil)
        let bitmapImage: CGImage = context.createCGImage(ciimage, from: extent)!
        
        bitmapRef.interpolationQuality = CGInterpolationQuality.none
        bitmapRef.scaleBy(x: scale, y: scale);
        bitmapRef.draw(bitmapImage, in: extent)
        // 2.保存bitmap到图片
        let scaledImage: CGImage = bitmapRef.makeImage()!
        
        return UIImage(cgImage: scaledImage)
    }
    
    /** *********** 渐变色 *********** */
    class func gradient(colors:[CGColor],
                  gradientType:GradientType,
                          size:CGSize = CGSize(width: Screen_Width, height: Screen_Height)) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, true, 1)
        let context = UIGraphicsGetCurrentContext()
        context!.saveGState()
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradient(colorsSpace: colorSpace,colors: colors as CFArray,locations: nil)
        let start:CGPoint
        let end : CGPoint
        switch gradientType {
        case .topToBotton:
            start = CGPoint.init(x: 0, y: 0)
            end = CGPoint.init(x: 0, y: size.height)
        case .LeftToRight:
            start = CGPoint.init(x: 0, y: 0)
            end = CGPoint.init(x: size.width, y: 0)
        case .UpleftToLowright:
            start = CGPoint.init(x: 0, y: 0)
            end = CGPoint.init(x: size.width, y: size.height)
        case .UprightToLowleft:
            start = CGPoint.init(x: size.width, y: 0)
            end = CGPoint.init(x: 0, y: size.height)
            
        }
        context!.drawLinearGradient(gradient!, start: start, end: end, options: CGGradientDrawingOptions(rawValue: 0))
        
        let image:UIImage! = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    func resizableImage() -> UIImage? {
        // 设置端盖的值
        let top = self.size.height * 0.5
        let left = self.size.width * 0.5
        let bottom = self.size.height * 0.5
        let right = self.size.width * 0.5
        
        // 设置端盖的值
        let edgeInsets = UIEdgeInsets.init(top: top, left: left, bottom: bottom, right: right)
        
        // 拉伸图片
        return resizableImage(withCapInsets: edgeInsets, resizingMode: .stretch)
    }
    
    // 图片缩放(按屏幕)
    func zoomImage(_ zoomwidth: CGFloat) -> UIImage {
        
        let zoomheight = (zoomwidth / self.size.width) * self.size.height
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: zoomwidth, height: zoomheight), false, UIScreen.main.scale)
        
        self.draw(in: CGRect(x: 0, y: 0, width: zoomwidth, height: zoomheight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage ?? self
    }
    func scaleImage(size:CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        self.draw(in: .init(x: 0, y: 0, width: size.width, height: size.height))
        let scale = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scale!
    }
    
    // 将图片旋转角度
    func rotatedByDegrees(_ degree: CGFloat) -> UIImage {
        let radians = CGFloat.pi * degree / 180
        
        let box = UIView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        box.transform = CGAffineTransform(rotationAngle: radians)
        
        let boxSize = box.frame.size
        
        UIGraphicsBeginImageContext(boxSize)
        
        guard let bitmap = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return self
        }
        
        bitmap.translateBy(x: boxSize.width / 2, y: boxSize.height / 2)
        
        bitmap.rotate(by: radians)
        
        bitmap.scaleBy(x: 1.0, y: -1.0)
        
        guard let `cgImage` = cgImage else {
            UIGraphicsEndImageContext()
            return self
        }
        
        bitmap.draw(cgImage, in: CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height))
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return self
        }
        
        return image
    }
    
    
}
#if canImport(UIKit)
import UIKit

// MARK: - Properties
public extension UIImage {
    
    /// UIImage的大小（以字节为单位）
    var bytesSize: Int {
        return jpegData(compressionQuality: 1)?.count ?? 0
    }
    
    /// UIImage的大小（以千字节为单位）
    var kilobytesSize: Int {
        return (jpegData(compressionQuality: 1)?.count ?? 0) / 1024
    }
    
    /// 带有.always的UIImage原始渲染模式。
    var original: UIImage {
        return withRenderingMode(.alwaysOriginal)
    }
    
    /// 具有.alwaysTemplate呈现模式的UIImage。
    var template: UIImage {
        return withRenderingMode(.alwaysTemplate)
    }
    
}

// MARK: - Methods
public extension UIImage {
    
    /// SwifterSwift：从原始UIImage压缩的UIImage。
    ///
    ///-参数质量：生成的JPEG图像的质量，表示为0.0到1.0之间的值。 值0.0表示最大压缩（或最低质量），而值1.0表示最小压缩（或最佳质量）（默认值为0.5）。
    ///-返回：可选的UIImage（如果适用）。
    func compressed(quality: CGFloat = 0.5) -> UIImage? {
        guard let data = jpegData(compressionQuality: quality) else { return nil }
        return UIImage(data: data)
    }
    
    /// SwifterSwift：从原始UIImage压缩的UIImage数据。
    ///
    ///-参数质量：生成的JPEG图像的质量，表示为0.0到1.0之间的值。 值0.0表示最大压缩（或最低质量），而值1.0表示最小压缩（或最佳质量）（默认值为0.5）。
    ///-返回：可选数据（如果适用）。
    func compressedData(quality: CGFloat = 0.5) -> Data? {
        return jpegData(compressionQuality: quality)
    }
    
    /// SwifterSwift：UIImage裁剪为CGRect。
    ///
    ///-参数rect：CGRect将UIImage裁剪为。
    ///-返回：裁剪的UIImage
    func cropped(to rect: CGRect) -> UIImage {
        guard rect.size.width <= size.width && rect.size.height <= size.height else { return self }
        let scaledRect = rect.applying(CGAffineTransform(scaleX: scale, y: scale))
        guard let image = cgImage?.cropping(to: scaledRect) else { return self }
        return UIImage(cgImage: image, scale: scale, orientation: imageOrientation)
    }
    
    /// SwifterSwift：UIImage相对于纵横比缩放到高度。
    ///
    ///-参数：
    ///-toHeight：新高度。
    ///-opaque：指示位图是否不透明的标志。
    ///-返回：可选的缩放后的UIImage（如果适用）。
    func scaled(toHeight: CGFloat, opaque: Bool = false) -> UIImage? {
        let scale = toHeight / size.height
        let newWidth = size.width * scale
        UIGraphicsBeginImageContextWithOptions(CGSize(width: newWidth, height: toHeight), opaque, self.scale)
        draw(in: CGRect(x: 0, y: 0, width: newWidth, height: toHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// SwifterSwift：UIImage相对于宽高比缩放到宽度。
    ///
    ///-参数：
    ///-toWidth：新宽度。
    ///-opaque：指示位图是否不透明的标志。
    ///-返回：可选的缩放后的UIImage（如果适用）。
    func scaled(toWidth: CGFloat, opaque: Bool = false) -> UIImage? {
        let scale = toWidth / size.width
        let newHeight = size.height * scale
        UIGraphicsBeginImageContextWithOptions(CGSize(width: toWidth, height: newHeight), opaque, self.scale)
        draw(in: CGRect(x: 0, y: 0, width: toWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// SwifterSwift：创建旋转给定角度的接收器的副本。
    ///
    /// //将图像旋转180°
    /// image.rotated（by：Measurement（值：180，单位：.degrees））
    ///
    ///-参数angle：图像旋转角度的角度。
    ///-返回：旋转给定角度的新图像。
    @available(tvOS 10.0, watchOS 3.0, *)
    func rotated(by angle: Measurement<UnitAngle>) -> UIImage? {
        let radians = CGFloat(angle.converted(to: .radians).value)
        
        let destRect = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: radians))
        let roundedDestRect = CGRect(x: destRect.origin.x.rounded(),
                                     y: destRect.origin.y.rounded(),
                                     width: destRect.width.rounded(),
                                     height: destRect.height.rounded())
        
        UIGraphicsBeginImageContext(roundedDestRect.size)
        guard let contextRef = UIGraphicsGetCurrentContext() else { return nil }
        
        contextRef.translateBy(x: roundedDestRect.width / 2, y: roundedDestRect.height / 2)
        contextRef.rotate(by: radians)
        
        draw(in: CGRect(origin: CGPoint(x: -size.width / 2,
                                        y: -size.height / 2),
                        size: size))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// SwifterSwift：创建旋转给定角度（以弧度为单位）的接收器的副本。
    ///
    /// //将图像旋转180°
    /// image.rotated（作者：.pi）
    ///
    ///-参数弧度：以弧度为单位旋转图像的角度。
    ///-返回：旋转给定角度的新图像。
    func rotated(by radians: CGFloat) -> UIImage? {
        let destRect = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: radians))
        let roundedDestRect = CGRect(x: destRect.origin.x.rounded(),
                                     y: destRect.origin.y.rounded(),
                                     width: destRect.width.rounded(),
                                     height: destRect.height.rounded())
        
        UIGraphicsBeginImageContext(roundedDestRect.size)
        guard let contextRef = UIGraphicsGetCurrentContext() else { return nil }
        
        contextRef.translateBy(x: roundedDestRect.width / 2, y: roundedDestRect.height / 2)
        contextRef.rotate(by: radians)
        
        draw(in: CGRect(origin: CGPoint(x: -size.width / 2,
                                        y: -size.height / 2),
                        size: size))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// SwifterSwift：UIImage填充颜色
    ///
    ///-参数color：用于填充图像的颜色。
    ///-返回：用给定颜色填充的UIImage。
    func filled(withColor color: UIColor) -> UIImage {
        
        #if !os(watchOS)
        if #available(tvOS 10.0, *) {
            let format = UIGraphicsImageRendererFormat()
            format.scale = scale
            let renderer = UIGraphicsImageRenderer(size: size, format: format)
            return renderer.image { context in
                color.setFill()
                context.fill(CGRect(origin: .zero, size: size))
            }
        }
        #endif
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.setFill()
        guard let context = UIGraphicsGetCurrentContext() else { return self }
        
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        guard let mask = cgImage else { return self }
        context.clip(to: rect, mask: mask)
        context.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// SwifterSwift：带有颜色的UIImage
    ///
    ///-参数：
    ///-color：用于着色图像的颜色。
    ///-blendMode：如何混合色调
    ///-返回：以给定颜色着色的UIImage。
    func tint(_ color: UIColor, blendMode: CGBlendMode, alpha: CGFloat = 1.0) -> UIImage {
        let drawRect = CGRect(origin: .zero, size: size)
        
        #if !os(watchOS)
        if #available(tvOS 10.0, *) {
            let format = UIGraphicsImageRendererFormat()
            format.scale = scale
            return UIGraphicsImageRenderer(size: size, format: format).image { context in
                color.setFill()
                context.fill(drawRect)
                draw(in: drawRect, blendMode: blendMode, alpha: alpha)
            }
        }
        #endif
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer {
            UIGraphicsEndImageContext()
        }
        let context = UIGraphicsGetCurrentContext()
        color.setFill()
        context?.fill(drawRect)
        draw(in: drawRect, blendMode: blendMode, alpha: alpha)
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
    
    /// SwifterSwift：具有背景色的UImage
    ///
    ///-参数：
    ///-backgroundColor：用作背景色的颜色
    ///-返回：UIImage，背景色在alpha <1时可见
    func withBackgroundColor(_ backgroundColor: UIColor) -> UIImage {
        
        #if !os(watchOS)
        if #available(tvOS 10.0, *) {
            let format = UIGraphicsImageRendererFormat()
            format.scale = scale
            return UIGraphicsImageRenderer(size: size, format: format).image { context in
                backgroundColor.setFill()
                context.fill(context.format.bounds)
                draw(at: .zero)
            }
        }
        #endif
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        
        backgroundColor.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        draw(at: .zero)
        
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
    
    /// SwifterSwift：带有圆角的UIImage
    ///
    ///-参数：
    ///-radius：角半径（可选），如果未指定，则生成的图像将为圆形
    ///-返回：圆角四角的UIImage
    func withRoundedCorners(radius: CGFloat? = nil) -> UIImage? {
        let maxRadius = min(size.width, size.height) / 2
        let cornerRadius: CGFloat
        if let radius = radius, radius > 0 && radius <= maxRadius {
            cornerRadius = radius
        } else {
            cornerRadius = maxRadius
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        
        let rect = CGRect(origin: .zero, size: size)
        UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
        draw(in: rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /// SwifterSwift：图片的Base 64编码PNG数据。
    ///
    ///-返回：图片的以Base 64编码的PNG数据作为String。
    func pngBase64String() -> String? {
        return pngData()?.base64EncodedString()
    }
    
    /// SwifterSwift：图片的基于64位编码的JPEG数据。
    ///
    ///-参数compressionQuality：生成的JPEG图像的质量，表示为0.0到1.0之间的值。 值0.0表示最大压缩率（或最低质量），而值1.0表示最小压缩率（或最佳质量）。
    ///-返回：图像的Base 64编码JPEG数据作为String。
    func jpegBase64String(compressionQuality: CGFloat) -> String? {
        return jpegData(compressionQuality: compressionQuality)?.base64EncodedString()
    }
    
}

// MARK: - Initializers
public extension UIImage {
    
    /// SwifterSwift：根据颜色和大小创建UIImage。
    ///
    ///-参数：
    ///-color：图像填充颜色。
    ///-size：图片大小。
    convenience init(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        
        defer {
            UIGraphicsEndImageContext()
        }
        
        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        
        guard let aCgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            self.init()
            return
        }
        
        self.init(cgImage: aCgImage)
    }
    
    /// SwifterSwift：从64位基本字符串创建新图像。
    ///
    ///-参数：
    ///-base64String：一个以64为底的String，代表图片
    ///-scale：解释从base-64字符串创建的图像数据时要采用的比例因子。 应用1.0的比例因子会导致图像的大小与图像的基于像素的尺寸匹配。 应用不同的比例因子会更改图像的大小，如`size`属性所报告的那样。
    convenience init?(base64String: String, scale: CGFloat = 1.0) {
        guard let data = Data(base64Encoded: base64String) else { return nil }
        self.init(data: data, scale: scale)
    }
    
    /// SwifterSwift：从URL创建新图像
    ///
    ///-重要提示：
    ///使用此方法将data：// URL转换为UIImage对象。
    ///不要使用此同步初始化程序来请求基于网络的URL。对于基于网络的URL，此方法可能会在慢速网络上将当前线程阻塞数十秒钟，从而导致较差的用户体验，并且在iOS中，可能会导致您的应用终止。
    ///相反，对于非文件URL，请考虑以异步方式使用它，使用URLSession类的`dataTask（with：completionHandler：）`方法或诸如AlamofireImage，Kingfisher，SDWebImage之类的库。或其他以执行异步网络映像加载。
    ///-参数：
    ///-url：URL，代表图片位置
    ///-scale：解释从URL创建的图像数据时要采用的比例因子。应用1.0的比例因子会导致图像的大小与图像的基于像素的尺寸匹配。应用不同的比例因子会更改图像的大小，如`size`属性所报告的那样。
    convenience init?(url: URL, scale: CGFloat = 1.0) throws {
        let data = try Data(contentsOf: url)
        self.init(data: data, scale: scale)
    }
    
}

#endif
