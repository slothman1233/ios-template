//
//  NSNotification+Extension.swift
//  Planet
//
//  Created by A1 on 2022/10/8.
//

import Foundation
 
extension NSNotification.Name {
    
    static let marketTypeChange = Notification.Name("MarketTypeChange")
    
    static let homeTypeChange = Notification.Name("homeTypeChange")
    
    static let login = Notification.Name("login")
    
    static let loginOut = Notification.Name("loginOut")
    
    static let updateVersion = Notification.Name("updateVersion")

}
