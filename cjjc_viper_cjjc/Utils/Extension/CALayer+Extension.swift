//
//  CALayer+Extension.swift
//  Planet
//
//  Created by A1 on 2022/9/30.
//

import Foundation

extension CALayer {
    
    
    class func separatorDashLayerWithLineLength(lineLength: NSInteger,
                                          lineSpacing: NSInteger,
                                          lineWidth: CGFloat,
                                          lineColor: CGColor,
                                          isHorizontal: Bool) -> CAShapeLayer {
        
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = lineColor
        layer.lineWidth = lineWidth
        layer.lineDashPattern =  [NSNumber(value: lineLength), NSNumber(value: lineSpacing)]
        layer.masksToBounds = true
        
        let path = CGMutablePath()
        if isHorizontal {
            path.move(to: CGPoint(x: 0, y: lineWidth / 2))
            path.addLine(to: CGPoint(x: Screen_Width, y: lineWidth / 2))
        } else {
            path.move(to: CGPoint(x: lineWidth / 2, y: 0))
            path.addLine(to: CGPoint(x: lineWidth / 2, y: Screen_Height))
        }
        layer.path = path
        
        return layer
    }
    
}



