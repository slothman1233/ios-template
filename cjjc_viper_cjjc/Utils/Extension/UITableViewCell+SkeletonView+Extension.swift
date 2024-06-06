//
//  UITableViewCell+Extension.swift
//  YiDa
//
//  Created by cjjc on 2022/8/6.
//

import Foundation
import UIKit

extension UITableViewCell {
    
    /// 显示骨架图
    /// - Parameter index: 显示层数
    func showCellSkt(_ index:Int = 2){
        
        self.isSkeletonable = true
        self.showAnimatedGradientSkeleton()
        
        contentView.subviews.forEach { view in
            view.isSkeletonable = true
            
            if index > 0 {sktNumber(v:view,index: index - 1)}
            view.showAnimatedGradientSkeleton()
        }
        
        contentView.isSkeletonable = true
        contentView.showAnimatedGradientSkeleton()
    }
    
    /// 显示骨架图
    /// - Parameters:
    ///   - v: 子view
    ///   - index: 剩余层数
    func sktNumber(v:UIView,index:Int){
        var count = index
        v.subviews.forEach { view in
            
            count -= 1
            if count > 0 {sktNumber(v: view,index: count)}
            
            view.isSkeletonable = true
            if view.isKind(of: UILabel.self) {
                (view as! UILabel).lastLineFillPercent = 100
            }
            view.showAnimatedGradientSkeleton()
        }
    }
    
    
    /// 隐藏骨架图
    func hide(){
        for v in self.subviews {
            v.hideSkeleton()
        }
        self.hideSkeleton()
        contentView.hideSkeleton()
    }
}
