//
//  TextView.swift
//  MVP
//
//  Created by cjjc on 2022/8/29.
//

import Foundation

class TextView : UITextView {
    var placeholder:String! = ""
    
    init(frame:CGRect = .zero) {
        super.init(frame: frame, textContainer: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextView.textDidChangeNotification, object: self)//观察是否有文字输入
    }
    
    override func draw(_ rect: CGRect) {
        if hasText{
            return//如果输入框内有文字，直接返回
        }
        placeholder.draw(in: CGRect(x:5,y:7,width:rect.width-10,height:rect.height), withAttributes: [NSAttributedString.Key.foregroundColor:"afafaf".Hex,NSAttributedString.Key.font:self.font ?? Font(12)])//占位符的位置坐标，字体大小以及绘制区域大小，如果你对占位符的大小和位置不满意，请在这修改
    }
    
    @objc func textDidChange(){
        setNeedsDisplay()//调用drawRect方法，不能手动调用drawRect方法
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
