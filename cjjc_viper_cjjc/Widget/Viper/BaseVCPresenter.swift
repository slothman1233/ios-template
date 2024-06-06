//
//  PresenterType.swift
//  Mall
//
//  Created by cjjc on 2022/7/15.
//

import Foundation

protocol PresenterProtocol : AnyObject{
    associatedtype I: InteractorProtocol
    /// A presenter
    var interactor: I { get }
    
    associatedtype R: RouterProtocol
    /// A presenter
    var router: R { get }
    
    func viewDidLoad ()
    func viewWillAppear()
    func viewDidDisappear()
    func dealloc()
    
    //跳转新页面并传值
    func pushNewVC(positiveModel: CallBackModel?)
    
    //跳转新页面
    func pushNewVC()
    //返回
    func back()
    
    //反向传值
    func callBack(model:CallBackModel?)
    
    //默认请求方法
    func loadData(para: Parameters?)
    
}
   
/// Optional methods related to view state.
extension PresenterProtocol {
    func viewDidDisappear() {}
//    func viewWillAppear() {}
//    func viewDidLoad () {}
    func dealloc() {}
    
    func back() {}
    func pushNewVC(){}
    func pushNewVC(positiveModel: CallBackModel?) {}
    //反向传值
//    func callBack(model:CallBackModel){}
    
    
    
}

class BasePresent<I:InteractorProtocol,R:RouterProtocol>: PresenterProtocol{
    var interactor: I
    
    var router: R
    
    // MARK: -  必须使用weak  否则无法释放
    weak var basicVc : BaseVCProtocol?
    
    typealias Block = (_ model:CallBackModel?)->Void
    var block : Block?
    
    init(i:I,r:R) {
        interactor = i
        router = r
    }
    
    func viewWillAppear() {
        
    }
    
    func viewDidLoad() {
        
    }
    
    func viewDidDisappear() {
        
    }
    
    func dellaoc() {
        
    }
    
    func back() {
        router.back(currVC: basicVc)
    }
    
    func pushNewVC(positiveModel: CallBackModel? = nil) {
        router.pushNewVC(currVC: basicVc,positiveModel: positiveModel)
    }
    
    func pushNewVC() {
        router.pushNewVC(currVC: basicVc)
    }
    //反向传值
    func callBack(model:CallBackModel?){
        pLog(model?.text)
    }
    //默认请求方法
    func loadData(para: Parameters?){
        
    }
    
//    required init() {}
}
