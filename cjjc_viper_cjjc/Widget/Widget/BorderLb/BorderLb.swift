//
//  BorderLb.swift
//  Planet
//
//  Created by cjjc on 2022/9/20.
//

import Foundation

class BorderLb: ChainLabel {
    override func drawText(in rect: CGRect) {
        let shadowOffset = self.shadowOffset
        let textColor = self.textColor
        let c = UIGraphicsGetCurrentContext()
        c?.setLineWidth(2.0) //字体边缘的宽度
        c?.setLineJoin(.round)
        
        c?.setTextDrawingMode(.stroke)
        self.textColor = Hex("#7A2100") //字体边缘加的颜色
        super.drawText(in: rect)
        
        c?.setTextDrawingMode(.fill)
        self.textColor = textColor
        self.shadowOffset = CGSize(width: 0, height: 0)
        super.drawText(in: rect)
        
        self.shadowOffset = shadowOffset
    }
}
