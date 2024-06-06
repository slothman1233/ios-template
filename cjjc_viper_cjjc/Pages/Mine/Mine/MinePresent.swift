//
//  MinePresent.swift
//  MVP
//
//  Created by cjjc on 2022/8/26.
//

import UIKit

class MinePresent<I:MineInteractorProtocol,R:MineRouterProtocol>: BasePresent<I, R>,MinePresentProtocol  {

    var model : CallBackModel!
    
    weak var vc : MineVCProtocol?
    override var basicVc: BaseVCProtocol?{
        didSet{
            vc = (basicVc as? MineVCProtocol)
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

}
