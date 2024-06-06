//
//  BaseViewPresent.swift
//  Mall
//
//  Created by cjjc on 2022/7/28.
//

import Foundation

protocol PresenterViewProtocol : AnyObject{
    associatedtype I: InteractorProtocol
    var interactor: I { get }
   
    func createView()
}

class BaseViewPresent<I:InteractorProtocol>: PresenterViewProtocol{
    var interactor: I
    
    weak var basicView : BaseViewProtocol?
    
    typealias Block = (_ model:CallBackModel)->Void
    var block : Block?
    
    init(i:I) {
        interactor = i
    }
    
    func createView() {
        
    }
}
