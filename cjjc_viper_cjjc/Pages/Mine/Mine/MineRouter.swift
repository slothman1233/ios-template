//
//  MineRouter.swift
//  MVP
//
//  Created by cjjc on 2022/8/26.
//

import UIKit


class MineRouter: BaseRouter,MineRouterProtocol {
    required init() {}
    
    class func build(currVC:Any,positiveModel:CallBackModel? = nil){
        let present = MinePresent.init(i: MineInteractor.init(), r: MineRouter.init())
        let vc = MineVC.init(present: present)
        
        present.basicVc = vc
        present.model = positiveModel
        present.block = {model in
            (currVC as? BasicVC)?.callBack(model: model)
        }
        vc.hidesBottomBarWhenPushed = true
        (currVC as? UIViewController)?.navigationController?.pushViewController(vc, animated: true)
    }
    
    class func buildVC()->BasicVC{
        let present = MinePresent.init(i: MineInteractor.init(), r: MineRouter.init())
        let vc = MineVC.init(present: present)
        
        present.basicVc = vc
        
        return vc
    }
}
