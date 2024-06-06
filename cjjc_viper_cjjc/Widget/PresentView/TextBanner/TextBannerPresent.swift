//
//  TextBannerPresent.swift
//  YiDa
//
//  Created by cjjc on 2022/8/5.
//

import UIKit

class TextBannerPresent<I:TextBannerInteractorProtocol>: BaseViewPresent<I>,TextBannerPresentProtocol  {

    var model : CallBackModel!
    
    weak var vc : TextBannerViewProtocol?
    override var basicView: BaseViewProtocol?{
        didSet{
            vc = (basicView as? TextBannerViewProtocol)
        }
    }
    
    weak var delegate : TextBannerDelegate?
    
    override init(i: I) {
        
        super.init(i: i)
        request()
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    // 查看更多
    func moreClick(){
        self.delegate?.moreClick()
    }
    
    // 当前点击内容
    func itemClick(index:Int){
        self.delegate?.itemClick(index: index)
    }

    
    func request() {
        let para : [String:Any] = ["pageNo":1,"pageSize":20]
        
        interactor.request(para: para) { [weak self] model in
            self?.vc?.updateGroup(titles: (model.result as? [String])!)
        } fail: { error in
            
        }

    }
}
