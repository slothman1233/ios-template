//
//  MineVC.swift
//  MVP
//
//  Created by cjjc on 2022/8/26.
//

import UIKit


class MineVC<P:MinePresentProtocol>: BaseVC<P>,MineVCProtocol {

    override init(present: P) {
        super.init(present: present)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        present.viewWillAppear()
    }
    
    override func callBack(model: CallBackModel?) {
        
    }
    
    override func positive(model: CallBackModel?) {
       
    }

}
