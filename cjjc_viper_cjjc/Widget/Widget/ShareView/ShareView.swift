//
//  ShareView.swift
//  YiDa
//
//  Created by cjjc on 2022/8/2.
//

import UIKit

class ShareView: UIView {
    var back : UIView!
    
    var cancleBtn : ChainBtn!
    
    var block : ((_ index : Int)->Void)?
    
    init(handle:((_ index : Int)->Void)?) {
        super.init(frame: .init(x: 0, y: 0, width: Screen_Width, height: Screen_Height))
        self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
//        UIApplication.shared.keyWindows.addSubview(self)
        
//        UIApplication.shared.keyWindows.isUserInteractionEnabled = true
        self.isUserInteractionEnabled = true
        self.alpha = 0.1
        
        block = handle
        
        back = initView()
        back.frame = .init(x: 0, y: Screen_Height, width: Screen_Width, height: 170+kBlankHeight)
        back.backgroundColor = .white
        self.back.corner(topLeft: 25, topRight: 25, bottomLeft: 0, bottomRight: 0)
        
        
        var ar : [ChainBtn] = []
        var lastBtn : ChainBtn!
        let titles = ["保存名片","分享朋友圈","分享微信好友","复制链接"]
        let imgs = [R.image.invi_tu(),R.image.invi_pengyouquan(),R.image.invi_weixin(),R.image.invi_fuzhi()]
        for i in 0..<titles.count {
            let btn = initBtn(titles[i])
            btn.tag = 100+i
            btn.cImage(imgs[i]).cTitleColor(.black).cTarget(self, #selector(btnClick(sender:)))
            back.addSubview(btn)
            
            ar.append(btn)
            
            DispatchQueue.main.asyncAfter(deadline: .now()+0.1, execute: {
                btn.hw_locationAdjust(buttonMode: .Top, spacing: 14)
            })
            lastBtn = btn
        }
        ar.snp.distributeSudokuViews(verticalSpacing: 10, horizontalSpacing: 10, warpCount: 4, edgeInset: .init(top: 0, left: 0, bottom: 0, right: 0), itemHeight: 108, topConstrainView: nil)
        
        
        let line = initLb()
        line.cBackColor("#EBEBEB".Hex)
        back.addSubview(line)
        line.snp.makeConstraints { make in
            make.left.equalTo(22)
            make.right.equalTo(-22)
            make.height.equalTo(1)
            make.top.equalTo(lastBtn.snp.bottom).offset(1)
        }
        
        cancleBtn = initBtn("取消")
        cancleBtn.cTitleColor("000000".Hex).cFont(FontBold(18)).cTarget(self, #selector(hide))
        back.addSubview(cancleBtn)
        cancleBtn.snp.makeConstraints { make in
            make.left.right.equalTo(back)
            make.height.equalTo(62)
            make.top.equalTo(line.snp.bottom)
            
        }
    }
    @objc func btnClick(sender:ChainBtn){
        if (block != nil) {
            block!(sender.tag - 100)
        }
//        if sender.tag-100 == 4 {
//            hide()
//        }
        hide()
    }
    func show(){
        UIApplication.shared.keyWindows.addSubview(self)
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1
            self.back.y = Screen_Height-0-self.back.height
//            self.back.snp.updateConstraints { make in
//                make.bottom.equalTo(0)
//            }
        }) { (finished) in
            self.alpha = 1
        }
    }
    @objc func hide(){
        
        UIView.animate(withDuration: 0.3, animations: {
            self.back.y = Screen_Height
            
//            self.back.snp.updateConstraints { make in
//                make.bottom.equalTo(self.snp.bottom).offset(-170-self.safeAreaInsets.bottom)
//            }
            self.alpha = 0
        }) { (finished) in
            self.removeFromSuperview()
        }
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
