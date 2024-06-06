//
//  TextField.swift
//  Planet
//
//  Created by cjjc on 2022/8/29.
//

import Foundation
enum InputType {
    case phone
    case password
    case number//纯数字 字数显示使用maxLength （maxLength与maxPoint无法同时使用）
    case point//包含小数点 小数点后限制使用maxPoint
    case noChinese //不包含中文
    case numberOrLetter //只让输入数字和英文
}
class TextField : UITextField,UITextFieldDelegate{
    var rBlock : (()->Void)?
    var lBlock : (()->Void)?
    var lView : UIView!
    var lBtn : ChainBtn!
    var rView : UIView!
//    var rBtn : ChainBtn!
    var space : CGFloat = 0//左侧默认距离
    var canEdit : Bool = true//是否可编辑
    var widgetHeight  = 40
    
    var maxLength: Int = Int.max//最大位数
    var inputType: InputType? {
        didSet {
            switch inputType {
            case .phone:
                isNumber = true
                break
            case .password:
                isShow = true
                break
            case .number:
                isNumber = true
                break
            case .point:
                isPoint = true
                break
            case .noChinese:
                
                break
            case .numberOrLetter:
                
                break
            default:
                break
            }
        }
    }
   
    /** **********  是否纯数字(不包含小数点)  *********** */
    var isNumber : Bool?{
        didSet{
            guard isNumber == true else {
                return
            }
            self.keyboardType = .numberPad
        }
    }
    /** **********  是否纯数字(包含小数点)  *********** */
    var isPoint : Bool?{
        didSet{
            guard isPoint == true else {
                return
            }
            self.keyboardType = .decimalPad
        }
    }
    
    var maxPoint : Int = Int(Int16.max) {//小数点后位数
        didSet{
            isPoint = true
        }
    }
    // 删除按钮
    var isClear : Bool? {
        didSet{
            if isClear == true {
                clearButton.isHidden = false
                clearButton.cImage("tf_clear".image)
                clearButton.snp.updateConstraints { make in
                    make.width.equalTo(0)
                }
            }
        }
    }
    // 显示隐藏
    var isShow: Bool?{
        didSet{
            if isShow == true {
                self.isSecureTextEntry = true
                showButton.cImage("tf_open".image)
                
                showButton.snp.updateConstraints { make in
                    make.width.equalTo(25)
                }
            }else{
                self.isSecureTextEntry = false
            }
        }
    }
    var backColor : UIColor? {
        didSet{
            self.backgroundColor = backColor
        }
    }
   
    @objc func tfChange(){
        if isClear == true  && self.text?.count != 0{
            clearButton.isHidden = false
            clearButton.snp.updateConstraints { make in
                make.width.equalTo(25)
            }
        }else{
            clearButton.isHidden = true
            clearButton.snp.updateConstraints { make in
                make.width.equalTo(0)
            }
        }
        
        if self.text!.count <= 1 {
//            self.setNeedsLayout()
//            self.layoutIfNeeded()
            self.layoutSubviews()
        }
    }
    @objc func cleanText(){
        if isClear == true {
            self.text = ""
            clearButton.isHidden = true
            clearButton.snp.updateConstraints { make in
                make.width.equalTo(0)
            }
        }
    }
    
    @objc func showOrHide() {
        self.isSecureTextEntry = !self.isSecureTextEntry
        if self.isSecureTextEntry {
            showButton.cImage("tf_open".image)
        }else{
            showButton.cImage("tf_close".image)
        }
    }
    
//    var clearButton: ChainBtn!//删除
//    var showButton: ChainBtn!//显示隐藏按钮
//    var rBtn : ChainBtn!
    lazy var clearButton: ChainBtn = {
        let btn = ChainBtn.init(frame: .init(x: 0, y: 0, width: 30, height: widgetHeight))
        btn.cTarget(self, #selector(cleanText))
        btn.isHidden = true
        return btn
    }()
    
    lazy var showButton: ChainBtn = {
        let btn = ChainBtn.init()
        btn.cImage("tf_close".image).cTarget(self, #selector(showOrHide))
        return btn
    }()
    
    lazy var rBtn: ChainBtn = {
        let btn = ChainBtn.init()
        btn.cAlignment(.right).cTitleColor(BaseColor.color_3a3a3a).cFont(Font(14)).cTarget(self, #selector(rightClick(sender:)))
        btn.setTitleColor(BaseColor.color_979797, for: .disabled)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.leftViewMode = .always
        self.rightViewMode = .always
//        self.isNumber = false
        self.delegate = self
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1, execute: {
            self.isClear = true
        })
        self.font = FontBold(16)
        self.clearButtonMode = .whileEditing
        //        self.backgroundColor = "#24222E".Hex
        self.addTarget(self, action: #selector(tfChange), for: .editingChanged)
        
        lView = UIView.init(frame: .init(x: 0, y: 0, width: 0, height: widgetHeight))
        self.leftView = lView
        
        lBtn = ChainBtn.init(frame: .init(x: 12, y: 0, width: 50, height: widgetHeight))
        lBtn.cAlignment(.left).cTitleColor(.tipColor).cFont(Font(14)).cTarget(self, #selector(leftClick(sender:)))
        lView.addSubview(lBtn)
        
        rView = UIView.init()
        
        self.rightView = rView
        
        rView.add(rBtn,showButton,clearButton)
        
        rView.snp.makeConstraints { make in
            make.left.equalTo(clearButton)
            make.right.equalTo(rBtn).offset(5)
            make.height.equalTo(widgetHeight)
        }
        
        rBtn.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.right.equalTo(-5)
            make.width.equalTo(0)
        }
        
        showButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.right.equalTo(rBtn.snp.left)
            make.width.equalTo(0)
        }
        
        clearButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.right.equalTo(showButton.snp.left)
            make.width.equalTo(0)
        }
    }
    
    /** **********  占位符颜色  *********** */
    var placeholderColor: UIColor?{
        didSet{
            let para = NSMutableParagraphStyle.init()
            para.alignment = self.textAlignment
            self.attributedPlaceholder = NSAttributedString.init(string: self.placeholder ?? "", attributes:
                                                                    [NSAttributedString.Key.foregroundColor : placeholderColor ?? .tfPColor,
                                                                     NSAttributedString.Key.paragraphStyle: para])
        }
    }
    /** **********  leftview宽度   *********** */
    var leftWidth : CGFloat?{
        didSet{
            lBtn.width = leftWidth ?? 0
            lView.width = lBtn.width + 10
        }
    }
    /** **********   leftview图片  *********** */
    var leftImg : String?{
        didSet{
            lBtn.cImage(leftImg!.image)
            
            lBtn.width = leftWidth ?? (leftImg?.image?.width ?? 0)
            lView.width = lBtn.width + 10
        }
    }
    /** **********   leftview文字  *********** */
    var leftText : String?{
        didSet{
            lBtn.cTitle(leftText).cAlignment(.left)
            lBtn.width = leftWidth ?? ((leftText ?? "").ga_widthForComment(fontSize: 14))
            lView.width = lBtn.width + 10
        }
    }
    /** **********  rightview宽度 *********** */
    var rightWidth : CGFloat?{
        didSet{
            rBtn.snp.updateConstraints { make in
                make.width.equalTo(rightWidth ?? 0)
            }
        }
    }
    /** **********  rightview文字  *********** */
    var rightText : String?{
        didSet{
            var wid = 0.0
            rBtn.cTitle(rightText).cAlignment(.right)
            wid = rightWidth ?? ((rightText ?? "").ga_widthForComment(fontSize: 14) + 5)
            
            rBtn.snp.updateConstraints { make in
                make.width.equalTo(wid)
            }
        }
    }
    /** **********  rightview图片  *********** */
    var rightImg : String?{
        didSet{
            var wid = 0.0
            rBtn.cImage(rightImg?.image)
            wid = rightWidth ?? ((rightImg?.image?.width ?? 0) + 5)
//            rView.width = rBtn.width + 70
            
            rBtn.snp.updateConstraints { make in
                make.width.equalTo(wid)
            }
        }
    }
    /** **********  rightview图片点击  *********** */
    @objc func rightClick(sender:ChainBtn){
        if rBlock != nil {
            self.rBlock!()
        }
    }
    /** ********** leftview图片点击  *********** */
    @objc func leftClick(sender:ChainBtn){
        if lBlock != nil {
            self.lBlock!()
        }
    }
    // MARK: -  上左侧label
    lazy var topLb: BorderLb = {
        self.layer.masksToBounds = false
        //        let lb = ChainLabel.init(frame: .init(x: frame.origin.x, y: frame.origin.y-40, width: frame.width/2, height: 40))
        let lb = BorderLb.init()
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.01, execute: {
            self.superview?.addSubview(lb)
            lb.snp.makeConstraints { (make) in
                make.top.equalTo(self.snp.top).offset(-40)
                make.left.equalTo(self.snp.left)
                make.height.equalTo(40)
            }
        })
        //        self.addSubview(lb)
        return lb
    }()
    /** **********  上左文字 *********** */
    var topText : String?{
        didSet{
            self.topLb.cAlignment(.left).cTitleColor(topColor ?? Hex("333333")).cTitle(topText)
            self.topLb.font = Font(14)
        }
    }
    /** **********  上左颜色  *********** */
    var topColor : UIColor?{
        didSet{
            self.topLb.cTitleColor(topColor ?? Hex("333333"))
        }
    }
    // MARK: -  上右侧label
    lazy var topRLb: ChainLabel = {
        self.layer.masksToBounds = false
        //        let lb = ChainLabel.init(frame: .init(x: frame.width/2+frame.origin.x, y: frame.origin.y-40, width: frame.width/2, height: 40))
        let lb = ChainLabel.init()
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.01, execute: {
            self.superview?.addSubview(lb)
            lb.snp.makeConstraints { (make) in
                make.top.equalTo(self.snp.top).offset(-40)
                make.left.equalTo(self.snp.right).multipliedBy(0.5)
                make.width.equalTo(self.snp.width).multipliedBy(0.5)
                make.height.equalTo(40)
            }
        })
        //        self.addSubview(lb)
        return lb
    }()
    /** **********  上右文字  *********** */
    var topRText : String?{
        didSet{
            self.topRLb.cAlignment(.right).cTitleColor(topRColor ?? Hex("333333")).cTitle(topRText)
            self.topRLb.font = FontBold(17)
        }
    }
    /** **********  上右颜色  *********** */
    var topRColor : UIColor?{
        didSet{
            self.topRLb.cTitleColor(topRColor ?? Hex("333333"))
        }
    }
    // MARK: -  下左侧label
    lazy var botLb: ChainLabel = {
        self.layer.masksToBounds = false
        //        let lb = ChainLabel.init(frame: .init(x: frame.origin.x, y: frame.origin.y+frame.size.height, width: frame.width/2, height: 40))
        let lb = ChainLabel.init()
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.01, execute: {
            self.superview?.addSubview(lb)
            lb.snp.makeConstraints { (make) in
                make.top.equalTo(self.snp.bottom).offset(0)
                make.left.equalTo(self)
                make.width.equalTo(self.snp.width).multipliedBy(0.5)
                make.height.equalTo(40)
            }
        })
        //        self.addSubview(lb)
        return lb
    }()
    /** **********  下左文字  *********** */
    var botText : String?{
        didSet{
            self.botLb.cAlignment(.left).cTitleColor(botColor ?? .btnColor2).cTitle(botText)
            self.botLb.font = Font(12)
        }
    }
    /** **********  下左颜色  *********** */
    var botColor : UIColor?{
        didSet{
            self.botLb.cTitleColor(botColor ?? Hex("333333"))
        }
    }
    // MARK: -  下右侧label
    lazy var botRLb: ChainLabel = {
        self.layer.masksToBounds = false
        //        let lb = ChainLabel.init(frame: .init(x: frame.width/2+frame.origin.x, y: frame.origin.y+frame.size.height, width: frame.width/2-16, height: 40))
        let lb = ChainLabel.init()
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.01, execute: {
            self.superview?.addSubview(lb)
            lb.snp.makeConstraints { (make) in
                make.top.equalTo(self.snp.bottom).offset(0)
                make.left.equalTo(self.snp.right).multipliedBy(0.5)
                make.width.equalTo(self.snp.width).multipliedBy(0.5)
                make.height.equalTo(40)
            }
        })
        //        self.addSubview(lb)
        return lb
    }()
    /** **********  右下文字  *********** */
    var botRText : String?{
        didSet{
            self.botRLb.cAlignment(.right).cTitleColor(botRColor ?? .btnColor2).cTitle(botRText)
            self.botRLb.font = Font(12)
        }
    }
    /** **********  右下颜色  *********** */
    var botRColor : UIColor?{
        didSet{
            self.botRLb.cTitleColor(botRColor ?? Hex("333333"))
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return .init(x: bounds.origin.x+space+lView.width, y: bounds.origin.y, width: bounds.size.width-space-lView.width-rView.width, height: bounds.size.height)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return .init(x: bounds.origin.x+space+lView.width, y: bounds.origin.y, width: bounds.size.width-space-lView.width-rView.width, height: bounds.size.height)
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if isClear == true {
            clearButton.isHidden = textField.text == ""
            clearButton.snp.updateConstraints { make in
                if textField.text == "" {
                    make.width.equalTo(0)
                }else{
                    make.width.equalTo(25)
                }
            }
        }
        return canEdit
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if isClear == true {
            clearButton.isHidden = true
            clearButton.snp.updateConstraints { make in
                make.width.equalTo(0)
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text {
            
            if string.isEmpty {
                return true
            }
            
            //限制表情
            if textField.textInputMode?.primaryLanguage == "emoji" || ((textField.textInputMode?.primaryLanguage) == nil) {
                return false
            }
            
            //此处是限制空格输入
            if string != string.components(separatedBy: .whitespaces).joined(separator: "") {
                return false
            }
            
            if check(text, string, range) == false {
                return false
            }
            
            let textLength = text.count + string.count - range.length
            
            if textLength > maxLength {
                return false
            }
        }
        return true

    }
    
    private func check(_ text: String ,_ string: String,_ range: NSRange) -> Bool {
        if isNumber ?? false {
            if text.isNumber == false {
                return false
            }
            
            if string.isNumber == false {
                return false
            }
        }
        
        if isPoint ?? false {
            return text.point(string: string, range: range, count: maxPoint)
        }
        
        if inputType == .noChinese {
            return !string.isChineseCharacters
        }
        
        if inputType == .numberOrLetter {
            return string.numberOrLetter
        }
        return true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


