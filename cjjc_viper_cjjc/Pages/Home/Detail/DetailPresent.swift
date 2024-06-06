//
//  DetailPresent.swift
//  MVP
//
//  Created by cjjc on 2022/9/8.
//

import UIKit

class DetailPresent<I:DetailInteractorProtocol,R:DetailRouterProtocol>: BasePresent<I, R>,DetailPresentProtocol  {

    var model : CallBackModel!
    
    weak var vc : DetailVCProtocol?
    override var basicVc: BaseVCProtocol?{
        didSet{
            vc = (basicVc as? DetailVCProtocol)
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
        vc?.positive(model: model)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// 回调专用
    /// - Parameter model: CallBackModel
    override func callBack(model: CallBackModel?) {
        pLog("===================   接受到返回值 \(model?.text ?? "")")
        if let handle = block {
            handle(model)
        }
        back()
    }

}
