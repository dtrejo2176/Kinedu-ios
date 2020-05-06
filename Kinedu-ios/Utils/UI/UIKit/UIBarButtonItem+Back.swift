//
//  UIBarButtonItem+Back.swift
//  Kinedu-ios
//
//  Created by David Trejo on 3/30/20.
//  Copyright © 2020 David Trejo. All rights reserved.
//

import UIKit
import Bond

extension UIBarButtonItem {
    static func backBarButtonItem(withColor color: UIColor, tapHandler handler: @escaping () -> Void) -> UIBarButtonItem {
        let item = UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .plain, target: nil, action: nil)
        item.tintColor = color
        _ = item.reactive.tap.observeNext {
            handler()
        }
        return item
    }
}
