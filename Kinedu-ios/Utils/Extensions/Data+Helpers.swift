//
//  Data+Helpers.swift
//  KineduPOC
//
//  Created by David Trejo on 3/27/20.
//  Copyright © 2020 David Trejo. All rights reserved.
//

import Foundation

extension Data {
    
    var utf8String: String {
        return String(data: self, encoding: .utf8) ?? "[Not a String]"
    }
}
