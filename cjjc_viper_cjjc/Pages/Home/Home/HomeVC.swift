//
//  HomeVC.swift
//  MVP
//
//  Created by cjjc on 2022/9/8.
//

import UIKit


class HomeVC<P:HomePresentProtocol>: BaseVC<P>,HomeVCProtocol {
    lazy var tf: TextField = {
        let tf = initTf()
        tf.backColor = .white
        tf.placeholder = "请输入昵称"
        return tf
    }()
    
    lazy var btn: ChainBtn = {
        let btn = MainBtn.init()
        btn.cTitle("跳转到详情并传值").cTarget(self, #selector(btnClick))
        return btn
    }()
    
    lazy var lb: ChainLabel = {
        let lb = initLb("测试")
        lb.cBackColor(.red).cFont(20)
        lb.textInsets = .init(top: 5, left: 10, bottom: 5, right: 15)
        lb.round(cornerRadius: 5)
        return lb
    }()
    var stack : UIStackView!
    override init(present: P) {
        super.init(present: present)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //        tf.isNumber = true
        //        tf.maxLength = 3
        tf.maxPoint = 3
        tf.rightText = "测试"
        tf.isClear = true
        //        tf.canEdit = false
        tf.rBlock = {
            pLog(11)
        }
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
        
        view.addSubview(lb)
        lb.snp.makeConstraints { make in
            make.top.equalTo(btn.snp.bottom).offset(10)
            make.centerX.equalTo(btn)
        }
        
    }
     
    
    @objc func btnClick(){
        if tf.text == "" {
            return MessageDrop.showDrop(body: "请输入昵称")
        }
        let model = CallBackModel.init(text:tf.text!)
        present.pushNewVC(positiveModel: model)
//        present.pushNewVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        present.viewWillAppear()
    }
    
    /// 回调专用
    /// - Parameter model: CallBackModel
    override func callBack(model: CallBackModel?) {
        present.callBack(model: model)
        pLog("===================   接受到返回值 \(model?.text ?? "")")
        tf.text = model?.text
    }
    
    /// 正向传值专用
    /// - Parameter model: CallBackModel
    override func positive(model: CallBackModel?) {
        
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
