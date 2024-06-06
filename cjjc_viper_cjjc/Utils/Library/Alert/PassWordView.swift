//
//  PassWordView.swift
//  YiDa
//
//  Created by cjjc on 2022/8/3.
//

import UIKit

class PassWordView: UIView {
    var back : UIView!
    var block : ((_ pw : String)->Void)?
    init(money:String?,title:String? = "请输入支付密码",handle:((_ pw : String)->Void)?) {
        super.init(frame: .init(x: 0, y: 0, width: Screen_Width, height: Screen_Height))
        self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        self.isUserInteractionEnabled = true
        
        block = handle
        
        back = initView()
        back.frame = .init(x: 30, y: 0, width: Screen_Width-60, height: 215)
        back.backgroundColor = .white
        back.round(cornerRadius: 10)
        back.centerY = self.centerY-40
        
        let lb = initLb("请输入支付密码")
        lb.cFont(FontBold(16)).cTitleColor("000000".Hex)
        back.addSubview(lb)
        lb.snp.makeConstraints { make in
            make.centerX.equalTo(back)
            make.top.equalTo(15)
            make.height.equalTo(22)
        }
        
        let cancleBtn = initBtn("取消")
        cancleBtn.cTitleColor("#FF9234".Hex).cFont(Font(16)).cTarget(self, #selector(hide))
        back.addSubview(cancleBtn)
        cancleBtn.snp.makeConstraints { make in
            make.right.equalTo(0)
            make.height.equalTo(22)
            make.centerY.equalTo(lb)
            make.width.equalTo(70)
        }
        
        let line = initLb()
        line.cBackColor("#EBEBEB".Hex)
        back.addSubview(line)
        line.snp.makeConstraints { make in
            make.left.equalTo(0)
            make.right.equalTo(-0)
            make.height.equalTo(1)
            make.top.equalTo(lb.snp.bottom).offset(12)
        }
        
        let lb1 = initLb()
        lb1.cFont(Font(14)).cTitleColor("000000".Hex).cTitle(title)
        back.addSubview(lb1)
        lb1.snp.makeConstraints { make in
            make.centerX.equalTo(back)
            make.top.equalTo(line.snp.bottom).offset(20)
            make.height.equalTo(20)
        }
        
        let moneyLb = initLb()
        moneyLb.cFont(FontBold(24)).cTitleColor("#3A3A3A".Hex).cTitle(money)
        back.addSubview(moneyLb)
        moneyLb.snp.makeConstraints { make in
            make.centerX.equalTo(back)
            make.top.equalTo(lb1.snp.bottom).offset(12)
            make.height.greaterThanOrEqualTo(34)
        }
        
        
        var attr = KeenCodeUnitAttributes()
        attr.borderColor = "#E5E5E5".Hex
        attr.borderHighlightedColor = "#E5E5E5".Hex
        attr.borderErrorColor = "#E5E5E5".Hex
        attr.cursorColor = "#E5E5E5".Hex
        attr.borderRadius = 0
        attr.isSecureTextEntry = true
        attr.style = .followborder
        
        
        weak var ws = self
        let codev = KeenCodeUnit.init(frame: .init(x: back.width/2-269/2, y: back.height-44-20, width: 269, height: 44),attributes: attr) { str, bo in
            if bo == true {
                ws?.block!(str)
                ws?.hide()
            }
        }
        back.addSubview(codev)
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
