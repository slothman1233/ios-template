//
//  BarView.swift
//  SwiftTest
//
//  Created by apple on 2018/7/14.
//  Copyright © 2018年 KaoLaMall. All rights reserved.
//

import UIKit
// 声明设置代理方法
protocol BarViewDelegate : AnyObject {
    func left(btn:UIButton)
    func right(btn:UIButton)
    func label(_ label:UILabel)
}
class BarView: UIView {
    let headBackView = UIImageView.init()
    let label = UILabel.init()
    let leftBtn = ChainBtn.init(type: UIButton.ButtonType.custom)
    let rightBtn = ChainBtn.init()
    
    weak var delegate : BarViewDelegate?
    
    @objc dynamic  internal var labelTitle: String?  {
        didSet {
            label.text = labelTitle
        }
    }
    internal var leftBtnImage: String?  {
        didSet {
            guard let l = leftBtnImage else {
                leftBtn .setImage(UIImage.imageWithColor(.clear), for: UIControl.State.normal)
                return
            }
            if l.isEmpty {
                leftBtn .setImage(UIImage.imageWithColor(.clear), for: UIControl.State.normal)
            }else{
                leftBtn .setImage(UIImage.init(named: l ), for: UIControl.State.normal)
            }
        }
    }
    internal var rightBtnImage: String?  {
        didSet {
            guard let l = rightBtnImage else {
                rightBtn .setImage(UIImage.imageWithColor(.clear), for: UIControl.State.normal)
                return
            }
            if l.isEmpty {
                rightBtn .setImage(UIImage.imageWithColor(.clear), for: UIControl.State.normal)
            }else{
                rightBtn .setImage(UIImage.init(named: l ), for: UIControl.State.normal)
            }
        }
    }
    internal var leftBtnTitle: String?  {
        didSet {
            leftBtn .setTitle(leftBtnTitle!, for: UIControl.State.normal)
        }
    }
    internal var rightBtnTitle: String?  {
        didSet {
            rightBtn .setTitle(rightBtnTitle!, for: UIControl.State.normal)
        }
    }
    internal var leftBtnColor: UIColor?  {
        didSet {
            leftBtn.setTitleColor(leftBtnColor!, for: UIControl.State.normal)
        }
    }
    internal var rightBtnColor: UIColor?  {
        didSet {
            rightBtn.setTitleColor(rightBtnColor!, for: UIControl.State.normal)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        headBackView.isUserInteractionEnabled = true
        headBackView.alpha = 1
        addSubview(headBackView)
        headBackView.snp.makeConstraints { (make) in
            make.top.equalTo(-kStatusBarHeight)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
        }

        
        backgroundColor = UIColor.clear
        label.numberOfLines = 2
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.height.equalTo(44)
            make.bottom.equalTo(0)
            make.width.equalTo(self.snp.width).multipliedBy(0.5)
        }
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(labelClick(sender:)))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tap)
        
        
        leftBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        leftBtn.addTarget(self, action: #selector(leftClick(sender:)), for: UIControl.Event.touchUpInside)
        leftBtn.contentHorizontalAlignment = .left
        addSubview(leftBtn)
        leftBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(label)
            make.left.equalTo(12)
            make.width.equalTo(140)
            make.height.equalTo(40)
        }
        leftBtn.hw_locationAdjust(buttonMode: HWButtonMode.Left, spacing: 4)
        
        

        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        rightBtn.addTarget(self, action: #selector(rightClick(sender:)), for: UIControl.Event.touchUpInside)
        rightBtn.contentHorizontalAlignment = .right
        addSubview(rightBtn)
        rightBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(label)
            make.right.equalTo(-15)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }

    }
    @objc func labelClick(sender:UILabel!){
        self.delegate? .label(sender)
        
    }
    @objc func leftClick(sender:UIButton!){
        self.delegate? .left(btn: sender)
    }
    @objc func rightClick(sender:UIButton!){
        self.delegate?.right(btn: sender)
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
}
