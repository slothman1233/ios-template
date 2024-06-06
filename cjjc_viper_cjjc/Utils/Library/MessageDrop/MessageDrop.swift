//
//  Tips.swift
//  YiDa
//
//  Created by cjjc on 2022/8/1.
//

import Foundation

enum MessageDropType{
    case success
    case failure
    case info
}
//导航栏弹窗
class MessageDrop {
    
    ///信息提示
    class func showDrop(body:String,type:MessageDropType = .info){
        var view : MessageView!
        
        view = try! SwiftMessages.viewFromNib()
//        view.configureTheme(.info)
        
        var iconImage : UIImage = R.image.icon_valid()!
        if type == .success {
            iconImage = R.image.icon_succ()!
        }
        else if( type == .failure ){
            iconImage = R.image.icon_fail()!
        }
        
        view.configureContent(title: "", body: body,iconImage: iconImage)
        
        let img = UIImageView.init()
        img.image = UIImage.gradient(colors: ["#FFFAE7".Hex.cgColor,"#FFFFFF".Hex.cgColor,"#FFFFFF".Hex.cgColor,"#FFFFFF".Hex.cgColor], gradientType: UIImage.GradientType.LeftToRight)
        view.addSubview(img)
        img.snp.makeConstraints { make in
            make.left.equalTo(view)
            make.right.equalTo(view)
//            make.centerY.equalTo(view.bodyLabel!.snp.centerY)
            make.top.equalTo(view.snp.top).offset(0)
            make.height.equalTo(kStatusBarHeight+64)
        }
        img.round(cornerRadius: 10)
        
        view.button?.isHidden = true
        view.titleLabel?.isHidden = true
        view.leftLayoutMarginAddition = 20
        view.cornerRadius = 10
        view.backgroundColor = .white
        
//        var config = SwiftMessages.defaultConfig
//        config.presentationContext = .window(windowLevel: .normal)
        
        
        
        view.configureDropShadow()
        
        view.sendSubviewToBack(img)
        
//        SwiftMessages.show(config: config,view: view)
        SwiftMessages.show(view: view)
        Hud.hide()
    }
    
    
}
