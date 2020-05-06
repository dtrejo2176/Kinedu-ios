//
//  Error+Code.swift
//  KineduPOC
//
//  Created by David Trejo on 3/27/20.
//  Copyright © 2020 David Trejo. All rights reserved.
//

import Foundation

extension Error {
    var code: Int { return (self as NSError).code }
    var domain: String { return (self as NSError).domain }
}
