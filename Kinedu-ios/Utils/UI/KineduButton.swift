//
//  KineduButton.swift
//  Kinedu-ios
//
//  Created by David Trejo on 4/1/20.
//  Copyright © 2020 David Trejo. All rights reserved.
//

import UIKit

@IBDesignable
class KineduButton: UIButton {
    private var fontSize: CGFloat = 0
    
    @IBInspectable var dropsShadow: Bool = false {
        didSet {
            adjustAppearence()
        }
    }
    
    @IBInspectable var enabledBackgroundColor: UIColor = .kineduGreen {
        didSet {
            adjustAppearence()
        }
    }
    
    @IBInspectable var disabledBackgroundColor: UIColor = .gray3 {
        didSet {
            adjustAppearence()
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            adjustAppearence()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            adjustAppearence()
        }
    }

    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            adjustAppearence()
        }
    }

    @IBInspectable var shadowOpacity: Float = 0.35 {
        didSet {
            adjustAppearence()
        }
    }

    @IBInspectable var shadowOffsetHeight: CGFloat = 1.0 {
        didSet {
            adjustAppearence()
        }
    }

    @IBInspectable var shadowRadius: CGFloat = 3.0 {
        didSet {
            adjustAppearence()
        }
    }

    @IBInspectable var titleColor: UIColor = .gray2

}

private extension KineduButton {
    func adjustAppearence() {
        backgroundColor = isEnabled ? enabledBackgroundColor : disabledBackgroundColor
        alpha = isEnabled ? 1 :  0.9
        layer.cornerRadius = cornerRadius
        layer.shadowOpacity = dropsShadow && isEnabled ? shadowOpacity : 0
        layer.shadowRadius = shadowRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        setTitleColor(titleColor, for: .normal)
    }
    
    func configure() {
        layer.shadowRadius = 3
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: shadowOffsetHeight)
        adjustAppearence()
    }
}
