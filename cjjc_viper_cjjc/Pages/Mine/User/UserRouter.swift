//
//  UserRouter.swift
//  MVP
//
//  Created by cjjc on 2022/9/8.
//

import UIKit


class UserRouter: BaseRouter,UserRouterProtocol {
    required init() {}
    
    override func pushNewVC(currVC: Any?) {
        
    }
    
    override func pushNewVC(currVC: Any?, positiveModel: CallBackModel? = nil) {
        
    }
    
    class func build(currVC: Any?,positiveModel:CallBackModel? = nil){
        let present = UserPresent.init(i: UserInteractor.init(), r: UserRouter.init())
        let vc = UserVC.init(present: present)
        
        present.basicVc = vc
        present.model = positiveModel
        present.block = {model in
            (currVC as? BasicVC)?.callBack(model: model)
        }
        vc.hidesBottomBarWhenPushed = true
        (currVC as? UIViewController)?.navigationController?.pushViewController(vc, animated: true)
    }
    
    class func buildVC()->BasicVC{
        let present = UserPresent.init(i: UserInteractor.init(), r: UserRouter.init())
        let vc = UserVC.init(present: present)
        
        present.basicVc = vc
        
        return vc
    }
}
