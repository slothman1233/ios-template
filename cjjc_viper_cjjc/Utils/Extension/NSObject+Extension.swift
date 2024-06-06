//
//  NSObjectExtension.swift
//  hailiao
//
//  Created by lol on 2017/9/11.
//  Copyright © 2017年 hailiao. All rights reserved.
//

import Foundation

extension NSObject {
    
    /// className
    @nonobjc class var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last! as String
    }
    
    /// Identifier
    @nonobjc class var Identifier: String {
        return className.appending("_Identifier")
    }
}

extension URLRequest {
    static func allwoAnyHTTPSCertificateForHost(host:String) -> Bool {
        return true
    }
}
