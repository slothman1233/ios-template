//
//  Dictionary+Extension.swift
//  MVP
//
//  Created by cjjc on 2022/9/8.
//

import Foundation

extension Dictionary{
    /** **********  字典转字符串  *********** */
    var string : String{
        let data = try? JSONSerialization.data(withJSONObject: self, options: [])
        let str = String(data: data!, encoding: String.Encoding.utf8)
        return str ?? ""
    }
}
