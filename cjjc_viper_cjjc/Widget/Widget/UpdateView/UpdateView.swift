//
//  UpdateView.swift
//  YiDa
//
//  Created by cjjc on 2022/8/2.
//

import UIKit

class UpdateView: UIView {
    var back : UIView!
    var block : ((_ isUpdate : Bool)->Void)?
    var lb : ChainLabel!
    var close : ChainBtn!
    var tv : UITextView!
    var model : VersionModel? {
        didSet{
            guard let m = model else { return }
            tv.text = m.reserve
            close.isHidden = m.isEnforce == 1
        }
    }
    init(content:String?) {
        super.init(frame: .init(x: 0, y: 0, width: Screen_Width, height: Screen_Height))
        self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        self.isUserInteractionEnabled = true
        
        
        back = initView()
        back.frame = .init(x: 30, y: 0, width: 315, height: 390)
        back.backgroundColor = .white
        back.round(cornerRadius: 10)
        back.centerY = self.centerY
        back.centerX = self.centerX
        
        let img = initImg()
//        img.image = R.image.home_image_new()
        back.addSubview(img)
        img.snp.makeConstraints { make in
            make.left.right.top.equalTo(back)
            make.height.equalTo(147)
        }
      
        lb = initLb("更新内容：")
        lb.cTitleColor(BaseColor.color_000000).cFont(BaseFont.font_bold_16)
        back.addSubview(lb)
        lb.snp.makeConstraints { make in
            make.left.equalTo(40)
            make.top.equalTo(img.snp.bottom).offset(10)
            make.height.equalTo(22)
        }
        
        let btn = MainBtn.init()
        btn.cTitle("立即更新").cTarget(self, #selector(update))
        back.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.left.equalTo(BasePadding.space_12)
            make.right.equalTo(-BasePadding.space_12)
            make.height.equalTo(44)
            make.bottom.equalTo(-30)
        }
        
        let para = NSMutableParagraphStyle.init()
        para.lineSpacing = 5
        
        tv = TextView.init()
        tv.isEditable = false
        tv.textColor = BaseColor.color_000000
        tv.attributedText = content?.withParagraphStyle(para).withFont(BaseFont.font_14)
        back.addSubview(tv)
        tv.snp.makeConstraints { make in
            make.left.equalTo(lb).offset(-5)
            make.right.equalTo(-BasePadding.space_12)
            make.top.equalTo(lb.snp.bottom).offset(0)
            make.bottom.equalTo(btn.snp.top).offset(-0)
        }
        
        close = initBtn()
        close.cImage(R.image.new_icon_close()).cTarget(self, #selector(noUpdate))
        self.addSubview(close)
        close.snp.makeConstraints { make in
            make.centerX.equalTo(back)
            make.top.equalTo(back.snp.bottom)
            make.width.height.equalTo(60)
        }
       
    }
    @objc func update(){
        if let handle = block {
            handle(true)
        }
//        hide()
    }
    @objc func noUpdate(){
        if let handle = block {
            handle(false)
        }
        hide()
    }
    func show(){
        UIApplication.shared.keyWindows.addSubview(self)
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1
        }) { (finished) in
            self.alpha = 1
        }
    }
    @objc func hide(){
       
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { (finished) in
            self.removeFromSuperview()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
