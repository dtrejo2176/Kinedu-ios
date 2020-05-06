//
//  ScoreColorHelper.swift
//  Kinedu-ios
//
//  Created by David Trejo on 4/1/20.
//  Copyright © 2020 David Trejo. All rights reserved.
//

import UIKit

enum ScoreColorHelper {
    static func color(forScore score: Int) -> UIColor {
        return score < 70 ? .kineduRed : .kineduGreen
    }
}
