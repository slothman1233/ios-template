//
//  UIButton+HWExtension.swift
//  Swift-UIButton位置扩展
//
//  Created by Hanwen on 2018/7/2.
//  Copyright © 2018年 东莞市三心网络科技有限公司. All rights reserved.
//

import Foundation

enum HWButtonMode {
    /** *********** 图片在上面 *********** */
    case Top
    /** *********** 图片在下面 *********** */
    case Bottom
    /** *********** 图片在左边 *********** */
    case Left
    /** *********** 图片在右边 *********** */
    case Right
}
import UIKit

extension ChainBtn {
    
    // - Parameters:快速调整图片与文字位置
    //  - buttonMode: 图片所在位置
    //   - spacing: 文字和图片之间的间距
    func hw_locationAdjust(buttonMode: HWButtonMode,spacing: CGFloat) {
        
        let imageSize = self.imageRect(forContentRect: self.frame)
        let titleSize = self.titleRect(forContentRect: self.frame)
        
        switch (buttonMode){
        case .Bottom:
            self.imageView?.contentMode = .scaleAspectFit
            let hei = imageSize.height + titleSize.height
            self.titleRect = .init(x: 0, y: (self.height-hei-spacing)/2, width: self.width, height: titleSize.height)
            self.imageRect = .init(x: 0, y: (self.height-hei-spacing)/2+titleSize.height+spacing, width: self.width, height: imageSize.height)
            self.titleLabel?.textAlignment = .center
        case .Top:
            self.imageView?.contentMode = .scaleAspectFit
            let hei = imageSize.height + titleSize.height
            self.imageRect = .init(x: 0, y: (self.height-hei-spacing)/2, width: self.width, height: imageSize.height)
            self.titleRect = .init(x: 0, y: (self.height-hei-spacing)/2+imageSize.height+spacing, width: self.width, height: titleSize.height)
            self.titleLabel?.textAlignment = .center
        case .Right:
            
            if self.contentHorizontalAlignment == .left{
                self.titleEdgeInsets = UIEdgeInsets(top: 0,left: -imageSize.width,bottom: 0,right: 0)
                self.imageEdgeInsets = UIEdgeInsets(top: 0, left: spacing + titleSize.width, bottom: 0, right: 0)
            }
            else if  self.contentHorizontalAlignment == .right{
                self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: -titleSize.width)
                self.titleEdgeInsets = UIEdgeInsets(top: 0,left: -imageSize.width,bottom: 0,right: spacing + imageSize.width)
            }else{
                self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -0.5 * spacing - imageSize.width, bottom: 0, right: spacing * 0.5 + imageSize.width)
                self.imageEdgeInsets = UIEdgeInsets(top: 0, left: titleSize.width + 0.5*spacing, bottom: 0, right: -spacing * 0.5 - titleSize.width)
            }
        case .Left:
            if self.contentHorizontalAlignment == .left{
                self.titleEdgeInsets = UIEdgeInsets(top: 0,left: spacing,bottom: 0,right: 0)
            }
            else if  self.contentHorizontalAlignment == .right{
                self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: spacing)
            }else{
                self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0.5 * spacing, bottom: 0, right: -spacing * 0.5)
                self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing * 0.5, bottom: 0, right: spacing * 0.5)
            }
        }
    }
}
