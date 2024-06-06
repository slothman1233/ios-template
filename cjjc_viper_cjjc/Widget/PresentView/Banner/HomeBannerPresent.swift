//
//  HomeBannerPresent.swift
//  YiDa
//
//  Created by cjjc on 2022/8/5.
//

import UIKit

class HomeBannerPresent<I:HomeBannerInteractorProtocol>: BaseViewPresent<I>,HomeBannerPresentProtocol  {
    
    var model : CallBackModel!
    
    weak var vc : HomeBannerViewProtocol?
    override var basicView: BaseViewProtocol?{
        didSet{
            vc = (basicView as? HomeBannerViewProtocol)
        }
    }
    
    override init(i: I) {
        super.init(i: i)
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    func getBanner(is type: BannerType) {
        

        
        interactor.getBanner(is: type) {[weak self] model in
            
            if let array = model.result as? [PictureModel] {
                let images =  array.compactMap{
                    $0.pictureUrl
                }
                self?.vc?.updateImageArray(array: images)
            }
            
        } fail: { error in
            
        }

    }
    
    
}
