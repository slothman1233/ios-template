//
//  Stack.swift
//  MVP
//
//  Created by cjjc on 2022/9/19.
//

import Foundation
import UIKit

class Stack: UIView {
    
    lazy var st: UIStackView = {
        let st = UIStackView.init()
        
        return st
    }()

    var axis: NSLayoutConstraint.Axis = .horizontal {
        didSet {
            st.axis = axis
        }
    }
    var distribution: UIStackView.Distribution = .fill {
        didSet {
            st.distribution = distribution
        }
    }
    var alignment : UIStackView.Alignment = .fill {
        didSet {
            st.alignment = alignment
        }
    }
    var spacing : CGFloat = 0 {
        didSet {
            st.spacing = spacing
        }
    }
    var edgs : UIEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0) {
        didSet {
            st.snp.updateConstraints { make in
                make.edges.equalTo(edgs)
            }
        }
    }
    func addArrangedSubviews(_ views: UIView...) {
        views.compactMap({ $0 }).forEach {
            st.addArrangedSubview($0)
        }
    }
    
    
    func addArrangedSubviewsList(_ views: [UIView?]) {
        views.compactMap({ $0 }).forEach { st.addArrangedSubview($0) }
    }
    
    func removeArrangedSubviews() {
        st.removeSubviews()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(st)
        
        st.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
