//
//  UIFont+Helper.swift
//  Kinedu-ios
//
//  Created by David Trejo on 3/31/20.
//  Copyright © 2020 David Trejo. All rights reserved.
//

import UIKit

enum GothamFontWeight: String {
    case medium = "GothamRounded-Medium"
    case bold = "GothamRounded-Bold"
}

extension UIFont {
    class func gothamMediumFont(withSize size: CGFloat) -> UIFont {
        return gothamFont(withWeight: .medium, andSize: size)
    }
    
    class func gothamBoldFont(withSize size: CGFloat) -> UIFont {
        return gothamFont(withWeight: .bold, andSize: size)
    }
    
    class func gothamFont(withWeight weight: GothamFontWeight, andSize size: CGFloat) -> UIFont {
        return UIFont(name: weight.rawValue, size: size)!
    }
}
