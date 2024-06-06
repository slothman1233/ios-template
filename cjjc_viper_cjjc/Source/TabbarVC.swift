//
//  TabbarVC.swift
//  YHL
//
//  Created by apple on 2018/7/23.
//  Copyright © 2018年 KaoLaMall. All rights reserved.
//

import UIKit


class TabbarVC: UITabBarController,UITabBarControllerDelegate {
  
    var isLoad : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self

        let bg = UIView.init()
        bg.backgroundColor = Hex("#ffffff")
        bg.border(color: Hex("ffffff").withAlphaComponent(1), borderWidth: 1, borderType: .Top, scale: 0)
        self.tabBar.insertSubview(bg, at: 0)
        bg.snp.makeConstraints { (make) in
            make.bottom.left.top.right.equalTo(0)
        }
        
        self.addChildVc(childVC: HomeRouter.buildVC(), title: "首页", imageName: "tab_icon_home_nosele", selectImageName: "tab_icon_home_sele")
        
        
        self.addChildVc(childVC: MineRouter.buildVC(), title: "我的", imageName: "tab_icon_mine_nosele", selectImageName: "tab_icon_mine_sele")
       
    }
  
    /** *********** 添加子控制器 *********** */
    func addChildVc(childVC:UIViewController,title:String,imageName:String,selectImageName:String) {
        childVC.tabBarItem.title = title.language
        UITabBar.appearance().unselectedItemTintColor = BaseColor.color_979797
        
        childVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:BaseColor.color_979797], for: .normal)
        childVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:BaseColor.color_3A3A3A], for: .selected)
        childVC.tabBarItem.image = UIImage.init(named: imageName)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        childVC.tabBarItem.selectedImage = UIImage.init(named: selectImageName)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        let nav:UINavigationController = UINavigationController.init(rootViewController: childVC)
        nav.navigationBar.isHidden = true
        
        self.addChild(nav)
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        if viewController != self.viewControllers?[0] {
//            if Defaults.userInfo?.token == nil {
//                UIViewController.login()
//                return false
//            }
//        }
        
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

}
