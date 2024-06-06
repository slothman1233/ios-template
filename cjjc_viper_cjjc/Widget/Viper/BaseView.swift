//
//  BaseView.swift
//  Mall
//
//  Created by cjjc on 2022/7/28.
//

import UIKit


protocol BaseViewProtocol: AnyObject{
    
    /// 正向传值专用
    /// - Parameter model: CallBackModel
    func positive(model:CallBackModel?)
    
    /// present回调使用
    /// - Parameter model: 非列表类数据
    func updateModel(model: Any?)
    
    /// present回调使用
    /// - Parameters:
    ///   - list: 列表类数据
    ///   - noMoreData: 是否没有更多数据  适用于需要上拉加载更多
    func updateList(list: Any?, _ noMoreData: Bool)
}

class BaseView<P:PresenterViewProtocol>: UIView,BaseViewProtocol,ViewProtocol  {
    
    let present: P
    
    init(present:P) {
        self.present = present
        super.init(frame: .zero)
        
        createView()
    }
    func createView(){
        present.createView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 正向传值专用
    /// - Parameter model: CallBackModel
    func positive(model: CallBackModel?) {
        
    }
    
    /// present回调使用
    /// - Parameter model: 非列表类数据
    func updateModel(model: Any?){
        
    }
    
    /// present回调使用
    /// - Parameters:
    ///   - list: 列表类数据
    ///   - noMoreData: 是否没有更多数据  适用于需要上拉加载更多
    func updateList(list: Any?, _ noMoreData: Bool){
        
    }
    
}
