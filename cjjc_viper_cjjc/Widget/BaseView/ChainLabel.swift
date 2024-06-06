//
//  ChainLb.swift
//  MVP
//
//  Created by cjjc on 2022/8/29.
//

import Foundation

class ChainLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textColor = .lbColor
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @discardableResult
    func cTitle(_ title:String?) -> ChainLabel {
        self.text = title
        return self
    }
    @discardableResult
    func cTitleColor(_ color:UIColor) -> ChainLabel {
        self.textColor = color
        return self
    }
    @discardableResult
    func cBackColor(_ color:UIColor) -> ChainLabel {
        self.backgroundColor = color
        return self
    }
    @discardableResult
    func cFont(_ font:Any) -> ChainLabel {
        //        self.font = UIFont.init(name: "DengXian-Regular", size: font)
        //        self.font = UIFont.systemFont(ofSize: font)
        if (font as AnyObject).isKind(of: UIFont.self) {
            self.font = font as? UIFont
        }else{
            self.font = UIFont.systemFont(ofSize: JSON(font).stringValue.cgFloat)
        }
        //        self.font = font
        return self
    }
    @discardableResult
    func cAlignment(_ alignment:NSTextAlignment) -> ChainLabel {
        self.textAlignment = alignment
        return self
    }
    @discardableResult
    func cFrame(_ frame:CGRect) -> ChainLabel {
        self.frame = frame
        return self
    }
    @discardableResult
    func cTarget(_ target:Any,_ click:Selector) -> ChainLabel {
        let tap = UITapGestureRecognizer.init(target: target, action: click)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
        return self
    }
    /** **********  必须放在text和font后面  *********** */
    @discardableResult
    func cLineSpace(_ lineSpacing:CGFloat = 5) -> ChainLabel {
        
        let para = NSMutableParagraphStyle.init()
        para.lineSpacing = lineSpacing
        self.attributedText = self.text?.withFont(self.font).withParagraphStyle(para)
        return self
    }
    
    /// 可以设置文字上下左右的边距
    var textInsets: UIEdgeInsets = UIEdgeInsets.zero {
        didSet {
            setNeedsLayout()
        }
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        guard !(text?.isEmpty ?? true) else { return super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines) }
        
        let addInset = bounds.inset(by: textInsets)
        let realRect = super.textRect(forBounds: addInset, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textInsets.top, left: -textInsets.left, bottom: -textInsets.bottom, right: -textInsets.right)
        return realRect.inset(by: invertedInsets)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
}
