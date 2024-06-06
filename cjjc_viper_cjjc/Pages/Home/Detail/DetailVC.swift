//
//  DetailVC.swift
//  MVP
//
//  Created by cjjc on 2022/9/8.
//

import UIKit


class DetailVC<P:DetailPresentProtocol>: BaseVC<P>,DetailVCProtocol {
    lazy var tf: TextField = {
        let tf = initTf()
        tf.backColor = .white
        tf.placeholder = "请输入昵称"
        return tf
    }()
    
    lazy var btn: ChainBtn = {
        let btn = MainBtn.init()
        btn.cTitle("返回上一页并返回值").cTarget(self, #selector(btnClick))
        return btn
    }()
    override init(present: P) {
        super.init(present: present)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tf.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(44)
            make.top.equalTo(barView.snp.bottom).offset(100)
        }
        
        view.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(44)
            make.top.equalTo(tf.snp.bottom).offset(20)
        }
    }
    
    @objc func btnClick(){
        if tf.text == "" {
            return MessageDrop.showDrop(body: "请输入昵称")
        }
        let model = CallBackModel.init(text:tf.text!)
//        present.pushDetail(positiveModel: model)
        present.callBack(model: model)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        present.viewWillAppear()
    }
    
    /// 回调专用
    /// - Parameter model: CallBackModel
    override func callBack(model: CallBackModel?) {
        present.callBack(model: model)
    }
    
    /// 正向传值专用
    /// - Parameter model: CallBackModel
    override func positive(model: CallBackModel?) {
        tf.placeholder = model?.text
    }
    
    /// present回调使用
    /// - Parameter model: 非列表类数据
    override func updateModel(model: Any?) {
        
    }
    
    /// present回调使用
    /// - Parameters:
    ///   - list: 列表类数据
    ///   - noMoreData: 是否没有更多数据  适用于需要上拉加载更多
    override func updateList(list: Any?, _ noMoreData: Bool) {
        
    }
    
    /// 顶部弹窗
    /// - Parameters:
    ///   - message: 提示
    ///   - type: 提示类型
    ///   - model: present 回调model
    override func showDropMessage(message:String,type:MessageDropType,model:BaseModel? = nil){
        MessageDrop.showDrop(body: message, type: type)
    }
    
}
