//
//  String+Replacement.swift
//  KineduPOC
//
//  Created by David Trejo on 3/27/20.
//  Copyright © 2020 David Trejo. All rights reserved.
//

import Foundation

extension String {
    func replacingOccurences(ofRegex regexString: String, with replacementString: String) throws -> String {
        let regex = try NSRegularExpression(pattern: regexString, options: [])
        let mutableString = NSMutableString(string: self)
        regex.replaceMatches(in: mutableString, options: [], range: NSRange(location: 0, length: mutableString.length), withTemplate: replacementString)
        return String(mutableString)
    }
}
