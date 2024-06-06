//
//  UINavigationController+Extension.swift
//  Example
//
//  Created by apple on 2020/8/10.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

extension UINavigationController {
    func push(_ viewController:UIViewController,animated : Bool){
        viewController.hidesBottomBarWhenPushed = true
        self.pushViewController(viewController, animated: animated)
    }
}

