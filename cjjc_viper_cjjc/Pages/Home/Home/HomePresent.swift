//
//  HomePresent.swift
//  MVP
//
//  Created by cjjc on 2022/9/8.
//

import UIKit

class HomePresent<I:HomeInteractorProtocol,R:HomeRouterProtocol>: BasePresent<I, R>,HomePresentProtocol  {

    var model : CallBackModel!
    
    weak var vc : HomeVCProtocol?
    override var basicVc: BaseVCProtocol?{
        didSet{
            vc = (basicVc as? HomeVCProtocol)
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
