//
//  UserVC.swift
//  MVP
//
//  Created by cjjc on 2022/9/8.
//

import UIKit


class UserVC<P:UserPresentProtocol>: BaseVC<P>,UserVCProtocol {

    override init(present: P) {
        super.init(present: present)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        present.viewWillAppear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// 回调专用
    /// - Parameter model: CallBackModel
    override func callBack(model: CallBackModel?) {
        present.callBack(model: model)
    }
    
    /// 正向传值专用
    /// - Parameter model: CallBackModel
    override func positive(model: CallBackModel?) {
        
    }
    
    /// present回调使用
    /// - Parameter model: 非列表类数据
    override func updateModel(model: Any?) {
        
    }
    
    /// present回调使用
    /// - Parameters:
    ///   - list: 列表类数据
    ///   - noMoreData: 是否没有更多数据  适用于需要上拉加载更多
    override func updateList(list: Any?, _ noMoreData: Bool) {
        
    }
    
    /// 顶部弹窗
    /// - Parameters:
    ///   - message: 提示
    ///   - type: 提示类型
    ///   - model: present 回调model
    override func showDropMessage(message:String,type:MessageDropType,model:BaseModel? = nil){
        MessageDrop.showDrop(body: message, type: type)
    }
    
}
