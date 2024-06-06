//
//  HomeRouter.swift
//  MVP
//
//  Created by cjjc on 2022/9/8.
//

import UIKit


class HomeRouter: BaseRouter,HomeRouterProtocol {
    required init() {}
    
    override func pushNewVC(currVC: Any?) {
        DetailRouter.build(currVC: currVC)
    }
    
    override func pushNewVC(currVC: Any?, positiveModel: CallBackModel? = nil) {
        DetailRouter.build(currVC: currVC, positiveModel: positiveModel)
    }
    
    class func build(currVC: Any?,positiveModel:CallBackModel? = nil){
        let present = HomePresent.init(i: HomeInteractor.init(), r: HomeRouter.init())
        let vc = HomeVC.init(present: present)
        
        present.basicVc = vc
        present.model = positiveModel
        present.block = {model in
            (currVC as? BasicVC)?.callBack(model: model)
        }
        vc.hidesBottomBarWhenPushed = true
        (currVC as? UIViewController)?.navigationController?.pushViewController(vc, animated: true)
    }
    
    class func buildVC()->BasicVC{
        let present = HomePresent.init(i: HomeInteractor.init(), r: HomeRouter.init())
        let vc = HomeVC.init(present: present)
        
        present.basicVc = vc
        
        return vc
    }
}
