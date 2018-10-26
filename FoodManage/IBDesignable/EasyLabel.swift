//
//  EasyLabel.swift
//  homesecurity
//
//  Created by DeshPeng on 2018/7/18.
//  Copyright © 2018年 Hub 6 Inc. All rights reserved.
//

import UIKit

@IBDesignable
class EasyLabel: UILabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @IBInspectable open var isRounded: Bool = false {
        didSet {
            if isRounded {
                let roundedLength = self.frame.size.width<=self.frame.size.height ? self.frame.size.width : self.frame.size.height
                _cornerRadius = roundedLength/2
                self.layer.cornerRadius = _cornerRadius
            }

        }
    }

    fileprivate var _cornerRadius: CGFloat = 0

    @IBInspectable open var cornerRadius: CGFloat {
        set {
            if !isRounded {
                _cornerRadius = newValue
                self.layer.cornerRadius = _cornerRadius
            }
        }
        get {
            return _cornerRadius
        }
    }

    @IBInspectable open var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }

    @IBInspectable open var borderColor: UIColor = UIColor.gray {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }


    @IBInspectable open var isShadowed: Bool = false

    @IBInspectable open var shadowOpacity: Float = 0.8

    @IBInspectable open var shadowRadius: CGFloat = 6


    override func layoutSubviews() {
        super.layoutSubviews()
        addShadow()
    }

    func addShadow() {
        if isShadowed {
            self.layer.shadowPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: [.bottomLeft, .bottomRight, .topLeft, .topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
            self.layer.shadowOpacity = shadowOpacity
            self.layer.shadowRadius = shadowRadius
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
