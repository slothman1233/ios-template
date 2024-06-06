//
//  AlertSwift.swift
//  Atlantis
//
//  Created by ZhiLong Dai on 2020/3/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import SwiftyAttributes

//弹窗类型
enum AlertSType  {
    case alert
    case sheet
}
class Alert: UIView,UIGestureRecognizerDelegate {
    var block : ((_ index : Int,_ str : String) -> Void)?
    var name : ChainLabel!
    var content : ChainLabel!
    var back : UIView!
    
    var arr : [String] = []
    var sty : AlertSType!
    let titleColor = Hex("000000")
    let backColror = Hex("#f2f2f2")
    let blank : CGFloat = 20
    init(title : String?, message : String?,style : AlertSType,actionTitles : [String],handel : @escaping ((_ index : Int,_ str : String) -> Void)) {
        super.init(frame: .init(x: 0, y: 0, width: Screen_Width, height: Screen_Height))
        self.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        arr = actionTitles
        sty = style
        block = handel
        if style == .alert {
            back = UIView.init(frame: .init(x: Screen_Width/2 - 315/2, y: 30, width: 315, height: 140))
            back.backgroundColor = backColror
            self.addSubview(back)
            
            back.round(cornerRadius: 10)
            
            var hei1 : CGFloat = 24
            if title == nil {
                hei1 = 0
            }
            name = ChainLabel.init(frame: .init(x: 10, y: 20, width: back.width-20, height: hei1))
            name.font = FontBold(16)
            name.cTitleColor(titleColor).cAlignment(.center).cTitle(title)
            back.addSubview(name)
            
//            var hei : CGFloat = 50
            var hei : CGFloat = ((message ?? "").ga_heightForComment(fontSize: 16, width: back.width-20))
            if message == nil {
                hei = 0
            }
            
            content = ChainLabel.init(frame: .init(x: 10, y: name.bottom+12, width: back.width-20, height: hei))
            content.font = Font(14)
            content.numberOfLines = 0
            content.cTitleColor(titleColor).cAlignment(.center).cTitle(message)
            back.addSubview(content)
            pLog(content.height)
//            content.sizeToFit()
            
            back.height = content.bottom + blank
            back.center = self.center
            
            for i in 0..<actionTitles.count {
                let action = actionTitles[i]
                
                let line = UIView.init(frame: .init(x: 0, y: content.bottom+blank, width: back.width, height: 0.5))
                line.backgroundColor = RGB(214, 214, 214)
                back.addSubview(line)
                
                let btn = ChainBtn.init()
                btn.tag = 100 + i
                btn.cFont(FontBold(16)).cTitleColor(Hex("333333")).cTitle(action).cTarget(self,  #selector(btnClick(sender:)))
                back.addSubview(btn)
            
                if actionTitles.count == 1 {
                    btn.frame = .init(x: 0, y: line.bottom, width: back.width, height: 44)
                    btn.cTitleColor("#FF9234".Hex)
                }
                else if actionTitles.count == 2 {
                    btn.frame = .init(x: back.width/2*CGFloat(i), y: line.bottom, width: back.width/2+1, height: 44)
                    btn.border(color: RGB(214, 214, 214), borderWidth: 0.5, borderType: .Right, scale: 0)
                    if i == 0 {
                        btn.cTitleColor("#7E7E7E".Hex)
                    }else{
                        btn.cTitleColor("#FF9234".Hex)
                    }
                }
                else{
                    btn.frame = .init(x: 0, y: line.bottom+50*CGFloat(i), width: back.width, height: 44)
                    if i != actionTitles.count - 1 {
                        btn.border(color: RGB(214, 214, 214), borderWidth: 0.5, borderType: .Bottom, scale: 0)
                    }
                }
                back.height = btn.bottom
                back.center = self.center
            }
        }else{
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(hide))
            tap.delegate = self
            self.isUserInteractionEnabled = true
            self.addGestureRecognizer(tap)
            
            back = UIView.init(frame: .init(x: 15, y: Screen_Height, width: Screen_Width-30, height: 150))
            back.backgroundColor = backColror
            self.addSubview(back)
            back.round(cornerRadius: 10)
            
            self.alpha = 0.1
            
            var hei1 : CGFloat = 50
            if title == nil {
                hei1 = 0
            }
            name = ChainLabel.init(frame: .init(x: 10, y: 0, width: back.width-20, height: hei1))
            name.font = FontBold(20)
            name.cTitleColor(titleColor).cAlignment(.center).cTitle(title)
            back.addSubview(name)
            
            var hei : CGFloat = 50
            if message == nil {
                hei = 0
            }
            
            content = ChainLabel.init(frame: .init(x: 10, y: name.bottom, width: back.width-20, height: hei))
            content.font = FontBold(16)
            content.numberOfLines = 0
            content.cTitleColor(titleColor).cAlignment(.center).cTitle(message)
            back.addSubview(content)
            
            
            back.height = content.bottom + blank
            
            for i in 0..<actionTitles.count {
                let action = actionTitles[i]
                
                let line = UIView.init(frame: .init(x: 0, y: content.bottom+blank/2, width: back.width, height: 0.5))
                line.backgroundColor = RGB(214, 214, 214)
                back.addSubview(line)
                
                let btn = ChainBtn.init()
                btn.tag = 100 + i
                btn.cFont(Font(14)).cTitleColor(titleColor).cTitle(action).cTarget(self,  #selector(btnClick(sender:)))
                back.addSubview(btn)
                
                btn.frame = .init(x: 0, y: line.bottom+50*CGFloat(i), width: back.width, height: 50)
                if i != actionTitles.count - 1 {
                    btn.border(color: RGB(214, 214, 214), borderWidth: 0.5, borderType: .Bottom, scale: 0)
                }
                
                back.height = btn.bottom
            }
        }
    }
    
    func show(){
        
        if sty == AlertSType.alert{
            UIApplication.shared.keyWindows.addSubview(self)
            UIView.animate(withDuration: 0.3, animations: {
                self.alpha = 1
            }) { (finished) in
                self.alpha = 1
            }
        }else{
            UIApplication.shared.keyWindows.addSubview(self)
            UIView.animate(withDuration: 0.3, animations: {
                self.alpha = 1
                self.back.y = Screen_Height-kBlankHeight-self.back.height
            }) { (finished) in
                self.alpha = 1
            }
        }
    }
    @objc func btnClick(sender:ChainBtn){
        if block != nil{
            block!(sender.tag - 100,arr[sender.tag - 100])
        }
        hide()
    }
    @objc func hide(){
        if sty == AlertSType.alert{
            UIView.animate(withDuration: 0.3, animations: {
                self.alpha = 0
            }) { (finished) in
                self.removeFromSuperview()
            }
        }else{
            UIView.animate(withDuration: 0.3, animations: {
                self.back.y = Screen_Height
                self.alpha = 0
            }) { (finished) in
                self.removeFromSuperview()
            }
        }
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard (touch.view?.isDescendant(of: self.back))!  else {
            return true
        }
        return false
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
