//
//  Array+Group.swift
//  KineduPOC
//
//  Created by David Trejo on 3/28/20.
//  Copyright © 2020 David Trejo. All rights reserved.
//

import Foundation

extension Array {
    func group<U: Hashable>(by key: (Element) -> U) -> [[Element]] {
        //keeps track of what the integer index is per group item
        var indexKeys = [U : Int]()

        var grouped = [[Element]]()
        for element in self {
            let key = key(element)

            if let ind = indexKeys[key] {
                grouped[ind].append(element)
            }
            else {
                grouped.append([element])
                indexKeys[key] = grouped.count - 1
            }
        }
        return grouped
    }
}
