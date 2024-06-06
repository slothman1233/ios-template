//
//  VersionModel.swift
//  YiDa
//
//  Created by cjjc on 2022/8/11.
//

import Foundation

struct VersionModel: HandyJSON {
    var downloadUrl: String?
    var id: String?
    var isEnforce: Int = 0
    var reserve: String?
    var versionName: String?
    var versionType: String?
    var versionValue: String?
}
