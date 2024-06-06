//
//  UIStackView+Extension.swift
//  MVP
//
//  Created by cjjc on 2022/9/19.
//

import Foundation

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.compactMap({ $0 }).forEach { addArrangedSubview($0) }
    }
    
    
    /// 生成一个填充区域
    func spacer(_ space: CGFloat) -> UIView {
        let spacer = UIView()
        switch self.axis {
        case .horizontal:
            spacer.snp.makeConstraints { make in
                make.width.equalTo(space)
            }
        case .vertical:
            spacer.snp.makeConstraints { make in
                make.height.equalTo(space)
            }
        default:
            break
        }
        return spacer
    }
    
    /// 生成一个填充区域
    func spacer() -> UIView {
        let spacer = UIView()
        return spacer
    }
}
