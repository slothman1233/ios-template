//
//  EmptyView.swift
//  YiDa
//
//  Created by cjjc on 2022/8/2.
//

import UIKit

class EmptyView: UIView {
    var img : UIImageView!
    var tip : ChainLabel!
    var btn : ChainBtn!
    var block : (()->Void)?
    
    init(title:String?,btnText:String? = nil,handle:(()->Void)? = nil) {
        super.init(frame: .init(x: 0, y: 0, width: Screen_Width, height: Screen_Height-kTopHeight))
        
        self.backgroundColor = BaseColor.color_F7F7F7
        
        block = handle
        
        tip = initLb()
        tip.cTitle(title).cFont(BaseFont.lbFont).cTitleColor("#AFAFAF".Hex)
        tip.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
        }
        
        img = initImg()
        img.image = R.image.global_icon_no_state()
        img.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.bottom.equalTo(tip.snp.top).offset(-10)
            make.width.height.equalTo(125)
        }
        
        if btnText != nil {
            btn = initBtn()
            btn.cBackColor("#F6CE48".Hex).cTitle(btnText).cTitleColor("#3A3A3A".Hex).cFont(FontBold(16)).cTarget(self, #selector(click))
            btn.round(cornerRadius: 6)
            btn.snp.makeConstraints { make in
                make.top.equalTo(tip.snp.bottom).offset(18)
                make.height.equalTo(44)
                make.centerX.equalTo(self)
                make.width.equalTo(btn.intrinsicContentSize.width+40)
            }
        }
    }
    @objc func click(){
        if (block != nil) {
            block!()
        }
    }
   
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
