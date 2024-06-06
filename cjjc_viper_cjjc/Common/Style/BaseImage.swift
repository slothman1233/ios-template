//
//  BaseImage.swift
//  Viper
//
//  Created by cjjc on 2022/7/29.
//

import Foundation

struct BaseImage {
    
    // MARK: -  系统配置 bar左侧图片
    static let nav_back_black = "nav_back_black".image
    static let nav_back_white = "nav_back_white".image
    
    
    //占位符
    static let placeholderImage = "placeholder".image
    
    //btn 渐变色图片
    static let btnGradientImage = UIImage.gradient(colors: [UIColor.red.cgColor,UIColor.blue.cgColor], gradientType: UIImage.GradientType.LeftToRight)
    
    
    static let gradientImage = UIImage.gradient(colors: ["#F18E39".Hex.cgColor,"#F7B753".Hex.cgColor], gradientType: UIImage.GradientType.topToBotton)
}
