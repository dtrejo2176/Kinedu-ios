//
//  RoundedView.swift
//  TodoPago
//
//  Created by irapoport on 26/08/2019.
//  Copyright © 2019 Prisma. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedView: UIView {
    
    @IBInspectable var masksToBounds: Bool = true {
        didSet {
            configure()
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 20 {
        didSet {
            configure()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            configure()
        }
    }
    
    @IBInspectable var borderColor: UIColor = .borderGray {
        didSet {
            configure()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        layer.masksToBounds = masksToBounds
        layer.cornerRadius = cornerRadius
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
    }
}
