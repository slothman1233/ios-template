//
//  ChooseView.swift
//  YiDa
//
//  Created by A1 on 2022/8/19.
//

import UIKit

class ChooseView: UIView {
    
    private lazy var backView: UIView = {
        let view = initView()
        view.cornerRadius = 10
        view.backgroundColor = BaseColor.color_FFFFFF
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = BaseFont.font_bold_16
        return label
    }()
    
    private lazy var okBtn: ChainBtn = {
        let button = initBtn()
        button.cTitle("确认")
            .cTitleColor(BaseColor.color_FF9234)
            .cFont(BaseFont.font_bold_16)
            .cTarget(self, #selector(okButtonClick(sender:)))
        button.borderAll(borderWidth: 1.0/Screen_Scale, color: BaseColor.color_E5E5E5)
        return button
    }()
    
    private lazy var cancelBtn: ChainBtn = {
        let button = initBtn()
        button.cTitle("取消")
            .cTitleColor(BaseColor.color_7E7E7E)
            .cFont(BaseFont.font_bold_16)
            .cTarget(self, #selector(cancelButtonClick(sender:)))
        button.borderAll(borderWidth: 1.0/Screen_Scale, color: BaseColor.color_E5E5E5)
        return button
    }()
    
    private var btnArray: [ChainBtn] = []
    private var indexBlock: IndexCallback?
    
    init(title: String,
         actions: [String],
         handle: IndexCallback?) {
        super.init(frame: .init(x: 0, y: 0, width: Screen_Width, height: Screen_Height))
        
        self.indexBlock = handle
        self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        self.isUserInteractionEnabled = true
        self.alpha = 0.1
        
        backView.frame = CGRect(x: (Screen_Width - 315.w)/2.0, y: (Screen_Height - 140.w)/2.0, width: 315.w, height: 140.w)
        
        titleLabel.text = "选择支付类型"
        
        backView.addSubview(titleLabel)
        backView.addSubview(cancelBtn)
        backView.addSubview(okBtn)
        
        btnArray = actions.compactMap { title in
            let btn = ChainBtn(type: .custom)
            btn.cTitle(title)
                .cTitleColor(BaseColor.color_3A3A3A)
                .cFont(BaseFont.font_14)
                .cImage(R.image.icon_unSelect(), R.image.icon_select_yellow())
                .addTarget(self, action: #selector(buttonClick(sender:)), for: .touchUpInside)
            backView.addSubview(btn)
            DispatchQueue.main.asyncAfter(deadline: .now()+0.001, execute: {
                btn.hw_locationAdjust(buttonMode: .Left, spacing: 10)
            })
            return btn
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(BasePadding.space_20)
            make.centerX.equalToSuperview()
        }
        
        btnArray.snp.distributeSudokuViews(verticalSpacing: 10, horizontalSpacing: 10, warpCount: 2, edgeInset: .init(top: 4, left: 0, bottom: 0, right: 0), itemHeight: 50, topConstrainView: titleLabel)
        
        cancelBtn.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview()
            make.height.equalTo(44)
        }
        
        okBtn.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview()
            make.width.height.equalTo(cancelBtn)
            make.left.equalTo(cancelBtn.snp.right)
        }
        
        setupData()
    }
    
    private func setupData() {
        self.btnArray.first?.isSelected = true
    }
    
    @objc
    private func buttonClick(sender: UIButton) {
        for btn in btnArray {
            btn.isSelected = false
        }
        sender.isSelected = true
    }
    
    @objc
    private func okButtonClick(sender: UIButton) {
        var select: NSInteger?
        for  i in 0..<btnArray.count {
            if btnArray[i].isSelected == true {
                select = i
            }
        }
        
        if let indexBlock = indexBlock,
            let select = select{
            indexBlock(select)
        }
        hide()
    }
    
    @objc
    private func cancelButtonClick(sender: UIButton) {
        hide()
    }
    
    func show(){
        UIApplication.shared.keyWindows.addSubview(self)
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1
        }) { (finished) in
            self.alpha = 1
        }
    }
    @objc func hide(){
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { (finished) in
            self.removeFromSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
