//
//  BaseVC.swift
//  Mall
//
//  Created by cjjc on 2022/7/26.
//

import UIKit

// MARK: -  view相关 如要当前页面刷新数据 请自定义方法
protocol BaseVCProtocol : AnyObject{
    
    /// present回调使用
    /// - Parameter model: 非列表类数据
    func updateModel(model: Any?)
    
    /// present回调使用
    /// - Parameters:
    ///   - list: 列表类数据
    ///   - noMoreData: 是否没有更多数据  适用于需要上拉加载更多
    func updateList(list: Any?, _ noMoreData: Bool)
    
    /// 正向传值专用
    /// - Parameter model: CallBackModel
    func positive(model:CallBackModel?)
    
    /// 顶部弹窗
    /// - Parameters:
    ///   - message: 提示
    ///   - type: 提示类型
    ///   - model: present 回调model
    func showDropMessage(message:String,type:MessageDropType,model:BaseModel?)
    
}

class BaseVC<P:PresenterProtocol>: BasicVC,BaseVCProtocol,VCProtocol {
    
    let present: P
    
    init(present:P) {
        self.present = present
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //页面根据需要 自己自行使用
        //        present.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        present.viewWillAppear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        present.viewDidDisappear()
    }
    
    /// 回调专用
    /// - Parameter model: CallBackModel
    override func callBack(model: CallBackModel?) {
        present.callBack(model: model)
    }
    
    /// 正向传值专用
    /// - Parameter model: CallBackModel
    func positive(model: CallBackModel?) {
        
    }
    
    /// present回调使用
    /// - Parameter model: 非列表类数据
    func updateModel(model: Any?) {
        
    }
    
    /// present回调使用
    /// - Parameters:
    ///   - list: 列表类数据
    ///   - noMoreData: 是否没有更多数据  适用于需要上拉加载更多
    func updateList(list: Any?, _ noMoreData: Bool) {
        
    }
    
    /// 顶部弹窗
    /// - Parameters:
    ///   - message: 提示
    ///   - type: 提示类型
    ///   - model: present 回调model
    func showDropMessage(message:String,type:MessageDropType,model:BaseModel? = nil){
        MessageDrop.showDrop(body: message, type: type)
    }
    

}
