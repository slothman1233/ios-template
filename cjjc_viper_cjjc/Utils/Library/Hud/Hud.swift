//
//  HUD.swift
//  hailiao
//
//  Created by lol on 2017/5/26.
//  Copyright © 2017年 hailiao. All rights reserved.
//

import MBProgressHUD
//private let time:Double = 2
class Hud: NSObject {
    
    fileprivate static let window = Application.ApplicationKeyWindow()
    static let time:Double = 2
    
    class func showText(_ text: String) {
        hide()
        
        let hud = initialization()
        hud.label.text = text
        hud.label.numberOfLines = 0
        hud.label.font = UIFont.systemFont(ofSize: 16)
        hud.mode = .text
        hud.hide(animated: true, afterDelay: time)
    }
    /** *********** 不允许点击 *********** */
    class func showTextAllow(_ text: String) {
        hide()
        
        let hud = initialization(true)
        hud.label.text = text
        hud.label.numberOfLines = 0
        hud.label.font = UIFont.systemFont(ofSize: 16)
        hud.mode = .text
        hud.hide(animated: true, afterDelay: time)
    }
    
    class func showInfo(_ text: String) {
        hide()
        let hud = initialization()
        hud.label.text = text
        hud.label.numberOfLines = 0
        hud.label.font = UIFont.systemFont(ofSize: 16)
//        hud.customView = UIImageView(image: UIImage(named: "MBProgressHUD.bundle/success.png"))
        hud.customView = UIImageView.init(image: UIImage.init(named: "icon_state_vali"))
        
        hud.mode = .customView
        hud.hide(animated: true, afterDelay: time)
    }
    
    /** *********** 不允许点击 *********** */
    class func showInfoAllow(_ text: String) {
        hide()
        let hud = initialization(true)
        hud.label.text = text
        hud.label.numberOfLines = 0
        hud.label.font = UIFont.systemFont(ofSize: 16)
//        hud.customView = UIImageView(image: UIImage(named: "MBProgressHUD.bundle/success.png"))
        hud.customView = UIImageView.init(image: UIImage.init(named: "icon_state_vali"))
        hud.mode = .customView
        hud.hide(animated: true, afterDelay: time)
    }
    
    class func showSuccess(_ text: String) {
        hide()
        let hud = initialization()
        hud.label.text = text
        hud.label.numberOfLines = 0
        hud.label.font = UIFont.systemFont(ofSize: 16)
//        hud.customView = UIImageView(image: UIImage(named: "MBProgressHUD.bundle/success.png"))
        hud.customView = UIImageView.init(image: UIImage.init(named: "icon_state_succ"))
        
        hud.mode = .customView
        hud.hide(animated: true, afterDelay: time)
    }
    /** *********** 不允许点击 *********** */
    class func showSuccessAllow(_ text: String) {
        hide()
        let hud = initialization(true)
        hud.label.text = text
        hud.label.numberOfLines = 0
        hud.label.font = UIFont.systemFont(ofSize: 16)
//        hud.customView = UIImageView(image: UIImage(named: "MBProgressHUD.bundle/success.png"))
        hud.customView = UIImageView.init(image: UIImage.init(named: "icon_state_succ"))
        hud.mode = .customView
        hud.hide(animated: true, afterDelay: time)
    }
    
    class func showFailure(_ text: String) {
        hide()
        let hud = initialization()
        hud.label.text = text
        hud.label.numberOfLines = 0
        hud.label.font = UIFont.systemFont(ofSize: 16)
//        hud.customView = UIImageView(image: UIImage(named: "MBProgressHUD.bundle/error.png"))
        hud.customView = UIImageView.init(image: UIImage.init(named: "icon_state_fail"))
        hud.mode = .customView
        hud.hide(animated: true, afterDelay: time)
    }
    /** *********** 不允许点击 *********** */
    class func showFailureAllow(_ text: String) {
        hide()
        let hud = initialization(true)
        hud.label.text = text
        hud.label.numberOfLines = 0
        hud.label.font = UIFont.systemFont(ofSize: 16)
//        hud.customView = UIImageView(image: UIImage(named: "MBProgressHUD.bundle/error.png"))
        hud.customView = UIImageView.init(image: UIImage.init(named: "icon_state_fail"))
        hud.mode = .customView
        hud.hide(animated: true, afterDelay: time)
    }
    
    class func showProgress(_ text: String) {
        hide()
        let hud = initialization()
        hud.label.text = text
//        hud.label.backgroundColor = UIColor.black
        hud.label.numberOfLines = 0
        hud.label.font = UIFont.systemFont(ofSize: 16)
    }
    /** *********** 不允许点击 *********** */
    class func showProgressAllow(_ text: String) {
        hide()
        let hud = initialization(true)
        hud.label.text = text
        hud.label.numberOfLines = 0
        hud.label.font = UIFont.systemFont(ofSize: 16)
    }
    
    /** *********** 不允许点击 *********** */
    class func showProgressAllow(_ text: String, _ img : String) {
        hide()
        let hud = initialization(true)
        hud.label.text = text
        hud.label.numberOfLines = 0
        hud.label.font = UIFont.systemFont(ofSize: 16)
        hud.customView = UIImageView(image: UIImage(named: img))
        hud.mode = .customView
    }
    
    class func showProgress() {
        hide()
        initialization()
    }
    /** *********** 不允许点击 *********** */
    class func showProgressAllow() {
        hide()
        initialization(true)
    }
    
    class func showProgressOfAfterDelay(_ delay: TimeInterval) {
        hide()
        let hud = initialization()
        hud.hide(animated: true, afterDelay: delay)
    }
    
    class func showProgressTextOfAfterDelay(_ text: String, delay: TimeInterval) {
        hide()
        let hud = initialization()
        hud.label.text = text
        hud.label.numberOfLines = 0
        hud.label.font = UIFont.systemFont(ofSize: 16)
        hud.hide(animated: true, afterDelay: delay)
    }
    
    class func hide() {
        MBProgressHUD.hide(for: window, animated: true)
    }
}

// MARK: 私有方法
extension Hud {

    @discardableResult
    fileprivate class func initialization() -> MBProgressHUD {
        let hud = MBProgressHUD.showAdded(to: window, animated: true)
        hud.bezelView.style = .solidColor
//        hud.bezelView.color = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        hud.bezelView.color = UIColor.black.withAlphaComponent(0.9)//UIColor.black.withAlphaComponent(0.9)
        hud.contentColor = Hex("ffffff",1)//UIColor.white
        hud.margin = 15
        hud.cornerRadius = 10
        
//        hud.isSquare = false
        hud.removeFromSuperViewOnHide = true
        hud.isUserInteractionEnabled = false
        
        return hud
    }
    
    
    @discardableResult
    fileprivate class func initialization(_ isClick:Bool) -> MBProgressHUD {
        let hud = MBProgressHUD.showAdded(to: window, animated: true)
        hud.bezelView.style = .solidColor
//        hud.bezelView.color = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        hud.bezelView.color = UIColor.black.withAlphaComponent(0.9)//UIColor.black.withAlphaComponent(0.9)
        hud.contentColor = Hex("ffffff",1)//UIColor.white
        hud.margin = 15
        hud.cornerRadius = 10
//        hud.isSquare = false
        hud.removeFromSuperViewOnHide = true
        hud.isUserInteractionEnabled = isClick
        
        return hud
    }
}
