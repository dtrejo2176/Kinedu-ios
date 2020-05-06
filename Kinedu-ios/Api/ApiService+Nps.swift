//
//  ApiService+Nps.swift
//  KineduPOC
//
//  Created by David Trejo on 3/27/20.
//  Copyright © 2020 David Trejo. All rights reserved.
//

import Foundation

extension ApiService {
    typealias NpsHandler = (Result<[Nps.CodingData], Error>) -> Void
    
    func getNps(then handler: @escaping NpsHandler) {
        let resource = NpsResource()
        let request = ApiRequest(resource: resource)
        perform(request: request, then: handler)
    }
}
