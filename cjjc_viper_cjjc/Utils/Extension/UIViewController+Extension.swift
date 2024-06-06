//
//  UIViewController+Extension.swift
//  Example
//
//  Created by apple on 2020/8/10.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

extension UIViewController {
    class func currentViewController(base: UIViewController? = UIApplication.shared.keyWindows.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return currentViewController(base: presented)
        }
        return base
    }
    
    class func changeRoot(vc:UIViewController){
        UIApplication.shared.keyWindows.rootViewController = nil
        UIApplication.shared.keyWindows.rootViewController?.modalTransitionStyle = .crossDissolve
        let animation = {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            UIApplication.shared.keyWindows.rootViewController = vc
            UIView.setAnimationsEnabled(oldState)
        }
        
        if let sharedApplication = UIApplication.shared.delegate?.window {
            UIView.transition(with: sharedApplication!, duration: 1, options: .transitionCrossDissolve, animations: animation)
        }
    }
    
    class func login(){
//        let view = LoginRouter.buildVC()
////        view.modalPresentationStyle = .fullScreen
//        let nav = UINavigationController.init(rootViewController: view)
//        nav.modalPresentationStyle = .fullScreen
////        vc?.present(nav, animated: true, completion: nil)
//
//        UIApplication.shared.keyWindows.rootViewController?.present(nav, animated: true)
    }
}
