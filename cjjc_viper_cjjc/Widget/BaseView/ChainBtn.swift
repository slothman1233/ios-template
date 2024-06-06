
import UIKit
import SwiftyJSON


private var key : Void?

class ChainBtn: UIButton {
    
    var imagePosition: HWButtonMode = .Left
    var imageSpace: CGFloat = 0
    var adjustEnable: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTitleColor(.btnColor, for: .normal)
        //        self.titleLabel?.numberOfLines = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @discardableResult
    func cTitle(_ title:String?,_ selectedTitle:String? = nil) -> ChainBtn {
        self.setTitle(title, for: .normal)
        self.setTitle(selectedTitle, for: .selected)
        return self
    }
    @discardableResult
    func cTitleColor(_ color:UIColor?,_ selectedColor:UIColor? = nil) -> ChainBtn {
        self.setTitleColor(color, for: .normal)
        self.setTitleColor(selectedColor, for: .selected)
        return self
    }
    @discardableResult
    func cFont(_ font:Any) -> ChainBtn {
        //        self.titleLabel?.font = UIFont.init(name: "DengXian-Regular", size: font)
        //        self.titleLabel?.font = UIFont.systemFont(ofSize: font)
        if (font as AnyObject).isKind(of: UIFont.self) {
            self.titleLabel?.font = font as? UIFont
        }else{
            self.titleLabel?.font = UIFont.systemFont(ofSize: JSON(font).stringValue.cgFloat)
        }
        return self
    }
    @discardableResult
    func cImage(_ image:UIImage?,_ selectedImgae:UIImage? = nil) -> ChainBtn {
        self.setImage(image, for: .normal)
        self.setImage(selectedImgae, for: .selected)
        return self
    }
    @discardableResult
    func cBackImage(_ image:UIImage?,_ selectedImgae:UIImage? = nil) -> ChainBtn {
        self.setBackgroundImage(image, for: .normal)
        self.setBackgroundImage(selectedImgae, for: .selected)
        return self
    }
    @discardableResult
    func cBackColor(_ color:UIColor) -> ChainBtn {
        self.backgroundColor = color
        return self
    }
    @discardableResult
    func cFrame(_ frame:CGRect) -> ChainBtn {
        self.frame = frame
        return self
    }
    @discardableResult
    func cAlignment(_ alignment:UIControl.ContentHorizontalAlignment) -> ChainBtn {
        self.contentHorizontalAlignment = alignment
        
        if alignment == .left {
            self.titleLabel?.textAlignment = .left
        }
        else if alignment == .center {
            self.titleLabel?.textAlignment = .center
        }
        else if alignment == .right {
            self.titleLabel?.textAlignment = .right
        }
        return self
    }
    
    func time(_ time : Int,_ title : String = ""){
        var text : String = title
        if title == "" {
            text = self.currentTitle ?? ""
        }
        self.isEnabled = false
        self.setTitle("重新发送\(time)秒", for: .normal)
        var t = time
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            t -= 1
            self.setTitle("重新发送\(t)秒", for: .normal)
            if t == 0{
                self.setTitle(text, for: .normal)
                self.isEnabled = true
                timer.invalidate()
            }
        }
    }
    
    @discardableResult
    func cTarget(_ target:Any,_ click:Selector) -> ChainBtn {
        self.addTarget(target, action: click, for: .touchUpInside)
        return self
    }
    
    var titleRect : CGRect?
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        if !(titleRect?.isEmpty ?? true) && titleRect != CGRect.zero{
            return titleRect ?? CGRect.zero
        }
        return super.titleRect(forContentRect: contentRect)
    }
    var imageRect : CGRect?
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        if !(imageRect?.isEmpty ?? true) && imageRect != CGRect.zero{
            return imageRect ?? CGRect.zero
        }
        return super.imageRect(forContentRect: contentRect)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if adjustEnable == true {
            hw_locationAdjust(buttonMode: imagePosition, spacing: imageSpace)
        }
    }
}

