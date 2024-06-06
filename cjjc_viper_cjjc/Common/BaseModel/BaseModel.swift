//
//  BasicModel.swift
//  Mall
//
//  Created by cjjc on 2022/7/13.
//

import Foundation


/// 正向 回调 数据专用  可根据自己需求加字段
struct CallBackModel:HandyJSON{
    var index : Int = 0
    var text : String = ""
    var data : HandyJSON?
    var list : Any?
//    public required init(){}
}
///网络请求专用model
struct BaseModel: HandyJSON {
    var code : String = "4004"
    var message : String = "请求失败"
    var url : String = ""
    var result : Any? //原始数据
    var model : Any? //单独handyjson  model
    var list : Any? //handyjson model数组
}



