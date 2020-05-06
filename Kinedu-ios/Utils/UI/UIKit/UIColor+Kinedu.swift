//
//  UIColor+Kinedu.swift
//  KineduPOC
//
//  Created by David Trejo on 3/27/20.
//  Copyright © 2020 David Trejo. All rights reserved.
//

import Foundation

import UIKit

extension UIColor {
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red / 256.0, green: green / 256.0, blue: blue / 256.0, alpha: 1.0)
    }
}

extension UIColor {
    static var kineduBlue: UIColor {
        return UIColor(red: 27.0, green: 117.0, blue: 187.0)
    }
    
    static var kineduDarkBlue: UIColor {
        return UIColor(red: 18.0, green: 100.0, blue: 164.0)
    }

    static var kineduGreen: UIColor {
        return UIColor(red: 120.0, green: 183.0, blue: 66.0)
    }

    static var kineduLightBlue: UIColor {
        return UIColor(red: 31.0, green: 173.0, blue: 223.0)
    }
    
    static var kineduRed: UIColor {
        return UIColor(red: 208.0, green: 2.0, blue: 27.0)
    }

    static var kineduYellow: UIColor {
        return UIColor(red: 247.0, green: 142.0, blue: 33.0)
    }
    
    static var gray1: UIColor {
        return UIColor(red: 244.0, green: 244.0, blue: 244.0)
    }
    
    static var gray2: UIColor {
        return UIColor(red: 235.0, green: 235.0, blue: 235.0)
    }
    
    static var gray3: UIColor {
        return UIColor(red: 204.0, green: 204.0, blue: 204.0)
    }
    
    static var gray4: UIColor {
        return UIColor(red: 153.0, green: 153.0, blue: 153.0)
    }
    
    static var gray5: UIColor {
        return UIColor(red: 102.0, green: 102.0, blue: 102.0)
    }
    
    static var gray6: UIColor {
        return UIColor(red: 51.0, green: 51.0, blue: 51.0)
    }
    
    static var borderGray: UIColor {
        return UIColor(red: 204.0, green: 204.0, blue: 204.0)
    }

}
