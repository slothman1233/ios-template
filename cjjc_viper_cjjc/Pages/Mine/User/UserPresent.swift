//
//  UserPresent.swift
//  MVP
//
//  Created by cjjc on 2022/9/8.
//

import UIKit

class UserPresent<I:UserInteractorProtocol,R:UserRouterProtocol>: BasePresent<I, R>,UserPresentProtocol  {

    var model : CallBackModel!
    
    weak var vc : UserVCProtocol?
    override var basicVc: BaseVCProtocol?{
        didSet{
            vc = (basicVc as? UserVCProtocol)
        }
    }
    
    override init(i: I, r: R) {
        
        super.init(i: i, r: r)
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// 回调专用
    /// - Parameter model: CallBackModel
    override func callBack(model: CallBackModel?) {
        pLog("===================   接受到返回值 \(model?.text ?? "")")
    }

}
