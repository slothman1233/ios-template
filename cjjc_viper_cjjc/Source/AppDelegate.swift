//
//  AppDelegate.swift
//  MVP
//
//  Created by cjjc on 2022/8/26.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // MARK: -  键盘管理器
        keyBoradSet()
        
        // MARK: -  清除图片缓存
//        clearImageCache()
        
        // MARK: -  网络缓存
        openNetCache()
        
        // MARK: -  bugly配置
        buglySet()
        
        // MARK: -  申请广告权限
        attrack()
        
        // MARK: -  屏幕适配
        SizeAdapter.template(CGSize(width: 375, height: 812))
        
        // MARK: -  网络监听  ip地址改变
        netIp()
        
        // MARK: -  进入主界面
        enterMain()
        
        return true
    }
    
    // 进入主界面
    func enterMain(){
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        pLog(Defaults.userInfo?.token)
//        if Defaults.userInfo?.token == nil {
//            self.window?.rootViewController = UINavigationController.init(rootViewController: LoginRouter.buildVC())
//        }else{
        self.window?.rootViewController = TabbarVC.init()
//        }
        
        self.window?.makeKeyAndVisible()
    }
    
    // 键盘设置
    func keyBoradSet(){
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.toolbarManageBehaviour = IQAutoToolbarManageBehaviour.bySubviews
    }
    
    // 获取ip
    func netIp(){
        Net.networkReachability { status in
            Defaults.netType = "\(status)"
            SwiftPublicIP.getPublicIP(url: PublicIPAPIURLs.ipv4.icanhazip.rawValue) { str, error in
                if let error = error {
                    pLog(error.localizedDescription)
                } else if let string = str {
                    Defaults.ip = string
                    pLog("ip地址====\(string)")
                }
            }
        }
    }
    
    // 获取广告跟踪权限
    func attrack(){
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                pLog(status.rawValue)
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    // 清除图片缓存
    func clearImageCache(){
        ImageCache.default.clearCache()
    }
    
    //开启网路缓存
    func openNetCache(){
        let urlCache = URLCache.init(memoryCapacity: 40*1024*1024, diskCapacity: 100*1024*1024, diskPath: nil)
        URLCache.shared = urlCache
    }
    
    // bugly设置
    func buglySet(){
        //        let config = BuglyConfig.init()
        //        config.debugMode = true
        //
        //        Bugly.start(withAppId: "2b7dd14ed0", config: config)
    }
    
}

//extension AppDelegate: WXApiDelegate {
//    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        return WXApi.handleOpen(url, delegate: self)
//    }
//    
//    func onReq(_ req: BaseReq) {
//        pLog(req)
//    }
//    
//    func onResp(_ resp: BaseResp) {
//        pLog(resp)
//    }
//    
//    
//}


//}

