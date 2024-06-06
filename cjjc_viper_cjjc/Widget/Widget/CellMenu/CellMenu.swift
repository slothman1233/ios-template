//
//  CellMenu.swift
//  YiDa
//
//  Created by cjjc on 2022/8/2.
//

import UIKit

class CellMenu: UIView {
    
    /// 横向cell视图
    /// - Parameters:
    ///   - leftImg: 左侧图标
    ///   - title: 左侧文字
    ///   - content: 右侧小蚊子
    ///   - rightIcon: 右侧小箭头
    ///   - rightImg: 右侧图标
    /// - Returns: view
    class func menu(leftImg:UIImage? = nil,title:String? = nil,content:String? = nil,rightIcon:UIImage? = R.image.home_icon_back(),rightImg:UIImage? = nil,rightImgUrl:String? = nil)->UIView{
        let back = UIView.init()
        back.backgroundColor = .white
        back.isUserInteractionEnabled = true
        
        if leftImg != nil {
            let left = UIImageView.init()
            left.image = leftImg
            back.addSubview(left)
            left.snp.makeConstraints { make in
                make.centerY.equalTo(back)
                make.width.height.equalTo(24)
                make.left.equalTo(12)
            }
        }
        
        
        let titleLb = ChainLabel.init()
        titleLb.cTitleColor("#3A3A3A".Hex).cFont(Font(14)).cTitle(title)
        titleLb.tag = 102
        back.addSubview(titleLb)
        titleLb.snp.makeConstraints { make in
            if leftImg != nil {
                make.left.equalTo(46)
            }else{
                make.left.equalTo(12)
            }
            make.centerY.equalTo(back)
        }
        
        
        let right = UIImageView.init()
        right.tag = 103
        right.image = rightIcon
        back.addSubview(right)
        right.snp.makeConstraints { make in
            make.right.equalTo(-13)
            make.width.height.equalTo(24)
            make.centerY.equalTo(back)
        }
        
        if rightImg != nil || rightImgUrl != nil{
            let right1 = UIImageView.init()
            right1.tag = 101
            if rightImgUrl != nil {
                right1.kfImage(rightImgUrl)
            }
            if rightImg != nil {
                right1.image = rightImg
            }
            
            right1.round(cornerRadius: 28)
            back.addSubview(right1)
            right1.snp.makeConstraints { make in
                make.centerY.equalTo(back)
                make.width.height.equalTo(55)
                make.right.equalTo(right.snp.left)
            }
            
        }
        
        let contentLb = ChainLabel.init()
        contentLb.tag = 100
        contentLb.cTitleColor("#979797".Hex).cFont(Font(14)).cTitle(content)
        back.addSubview(contentLb)
        contentLb.snp.makeConstraints { make in
            make.right.equalTo(right.snp.left).offset(0)
            make.centerY.equalTo(back)
        }
        
        
        let line = ChainLabel.init()
        line.backgroundColor = "#E5E5E5".Hex
        back.addSubview(line)
        line.snp.makeConstraints { make in
            make.left.equalTo(12)
            make.right.equalTo(-12)
            make.height.equalTo(1.0 / Screen_Scale)
            make.bottom.equalTo(-1.0 / Screen_Scale)
        }
        
        return back
    }

}
