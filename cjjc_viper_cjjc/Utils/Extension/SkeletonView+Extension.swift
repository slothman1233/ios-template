//
//  SkeletonView+Extension.swift
//  YiDa
//
//  Created by A1 on 2022/8/6.
//

import UIKit
import SkeletonView

extension UIView {
    
    
    /// 当前view 骨架图化
    func showSkt() {
        
        isSkeletonable = true
        if let label =  self as? UILabel {
            label.lastLineFillPercent =  100
        }
        
        if let textView = self as? UITextView {
            textView.lastLineFillPercent = 100
        }
        showAnimatedGradientSkeleton()
    }
    
    
    /// 当前view的子view 骨架图化
    func showSktAll(){
        
        isSkeletonable = true
        subviews.forEach { v in
            v.showSkt()
        }
    }
    
    /// 隐藏
    func hideSkt(){
        hideSkeleton()
    }
    
}
