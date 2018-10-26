//
//  EasyButton.swift
//  homesecurity
//
//  Created by DeshPeng on 2018/7/11.
//  Copyright © 2018年 Hub 6 Inc. All rights reserved.
//

import UIKit

class EasyButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                self.layer.borderColor = borderHighlightedColor.cgColor
                self.layer.backgroundColor = bgHighlightedColor.cgColor
            } else {
                self.layer.borderColor = borderNormalColor.cgColor
                self.layer.backgroundColor = bgNormalColor.cgColor
            }
        }
    }

    override var isEnabled: Bool {
        didSet {
            if !isEnabled {
                self.layer.borderColor = borderDisabledColor.cgColor
                self.layer.backgroundColor = bgDisabledColor.cgColor
            } else {
                self.layer.borderColor = borderNormalColor.cgColor
                self.layer.backgroundColor = bgNormalColor.cgColor
            }
        }
    }

    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.layer.borderColor = borderSelectedColor.cgColor
                self.layer.backgroundColor = bgSelectedColor.cgColor
            } else {
                self.layer.borderColor = borderNormalColor.cgColor
                self.layer.backgroundColor = bgNormalColor.cgColor
            }
        }
    }

    @IBInspectable open var isRounded: Bool = false {
        didSet {
            if isRounded {
                let roundedLength = self.frame.size.width <= self.frame.size.height ? self.frame.size.width : self.frame.size.height
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

    @IBInspectable open var borderNormalColor: UIColor = UIColor.gray {
        didSet {
            self.layer.borderColor = borderNormalColor.cgColor
        }
    }

    @IBInspectable open var borderHighlightedColor: UIColor = UIColor.gray

    @IBInspectable open var borderDisabledColor: UIColor = UIColor.gray

    @IBInspectable open var borderSelectedColor: UIColor = UIColor.gray

    @IBInspectable open var isShadowed: Bool = false

    @IBInspectable open var shadowOpacity: Float = 0.8

    @IBInspectable open var shadowRadius: CGFloat = 6

    @IBInspectable open var shadowColor: UIColor = UIColor.gray

    @IBInspectable open var shadowOffset: CGSize = CGSize.init(width: 0, height: 0)

    @IBInspectable open var bgNormalColor: UIColor = UIColor.white {
        didSet {
            self.layer.backgroundColor = bgNormalColor.cgColor
        }
    }

    @IBInspectable open var bgHighlightedColor: UIColor = UIColor.white {
        didSet {
            if self.isHighlighted {
                self.layer.backgroundColor = bgHighlightedColor.cgColor
            }
        }
    }

    @IBInspectable open var bgSelectedColor: UIColor = UIColor.white {
        didSet {
            if self.isSelected {
                self.layer.backgroundColor = bgSelectedColor.cgColor
            }
        }
    }

    @IBInspectable open var bgDisabledColor: UIColor = UIColor.white {
        didSet {
            if !self.isEnabled {
                self.layer.backgroundColor = bgDisabledColor.cgColor
            }
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        addShadow()
        addCorner()
    }

    fileprivate func addShadow() {
        if isShadowed {
            self.layer.shadowPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: [.bottomLeft, .bottomRight, .topLeft, .topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
            self.layer.shadowOpacity = shadowOpacity
            self.layer.shadowRadius = shadowRadius
            self.layer.shadowColor = shadowColor.cgColor
            self.layer.shadowOffset = shadowOffset
        }
    }

    fileprivate func addCorner() {
        if isRounded {
            let roundedLength = self.frame.size.width <= self.frame.size.height ? self.frame.size.width : self.frame.size.height
            _cornerRadius = roundedLength/2
            self.layer.cornerRadius = _cornerRadius
        } else {
            self.layer.cornerRadius = _cornerRadius
        }
    }

}
