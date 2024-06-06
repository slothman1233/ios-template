//
//  SkncApplication.swift
//  SKNC-swift
//
//  Created by apple on 2018/7/17.
//  Copyright © 2018年 KaoLaMall. All rights reserved.
//

import Foundation
let Application = UIApplication.shared
extension UIApplication {
    var keyWindows : UIWindow{
       if #available(iOS 13.0, *) {
           return UIApplication.shared.windows.filter {$0.isKeyWindow}.first ?? UIWindow.init()
       }else{
           return  UIApplication.shared.keyWindow!
       }
   }
    
    func ApplicationKeyWindow() -> UIWindow {
        return self.keyWindows
    }
    
    func ApplicationRootViewController() -> UIViewController {
        return self.keyWindows.rootViewController ?? UIViewController()
    }
    
    func ApplicationOpenURL(_ url: URL) {
        if self.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                self.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary(Dictionary<String, Any>()), completionHandler: nil)
            } else {
                self.openURL(url)
            }
        }
    }
    func topViewController() -> UIViewController? {
        var rootCtroller: UIViewController!
        let windows = UIApplication.shared.windows;
        for item in windows.reversed() {
            if let ctrl = item.rootViewController {
                rootCtroller = ctrl;
                break;
            }
        }
        return childViewController(ctroller: rootCtroller);
    }
    private func childViewController(ctroller: UIViewController?) -> UIViewController? {
        if let ctrl = ctroller?.presentedViewController {
            return childViewController(ctroller: ctrl);
        }else if let ctrl = ctroller as? UINavigationController {
            return childViewController(ctroller: ctrl.topViewController);
        }else if let ctrl = ctroller as? UITabBarController {
            return childViewController(ctroller: ctrl.selectedViewController);
        }
        return ctroller;
    }
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}

