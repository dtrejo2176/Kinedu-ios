//
//  UISegmentedControl+Kinedu.swift
//  Kinedu-ios
//
//  Created by David Trejo on 3/31/20.
//  Copyright © 2020 David Trejo. All rights reserved.
//

import UIKit

class KineduSegmentedControl: UISegmentedControl {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        let selectedAttributes = [
            NSAttributedString.Key.font: UIFont.gothamFont(withWeight: .medium, andSize: 13.0),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        let unselectedAttributes = [
            NSAttributedString.Key.font: UIFont.gothamFont(withWeight: .medium, andSize: 13.0),
            NSAttributedString.Key.foregroundColor: UIColor.kineduBlue
        ]
        self.setTitleTextAttributes(selectedAttributes, for: .selected)
        self.setTitleTextAttributes(unselectedAttributes, for: .normal)
        if #available(iOS 13.0, *) {
            self.layer.borderColor = UIColor.borderGray.cgColor
            self.layer.borderWidth = 1
            self.layer.cornerRadius = 4
        }
    }
}
