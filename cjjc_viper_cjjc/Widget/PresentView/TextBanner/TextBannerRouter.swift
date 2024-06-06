//
//  TextBannerRouter.swift
//  YiDa
//
//  Created by cjjc on 2022/8/25.
//

import Foundation

class TextBannerRouter{
    
    /// 初始化banner 相关组件
    /// - Returns: p: present层<interactor层>    v:view层
    class func buildView()->(p:TextBannerPresent<TextBannerInteractor>,v:UIView){
        let p = TextBannerPresent.init(i: TextBannerInteractor.init())
        let v = TextBannerView.init(present: p)
        
        p.vc = v
        
        return (p:p,v:v)
    }
}
