//
//  NpsResource.swift
//  KineduPOC
//
//  Created by David Trejo on 3/27/20.
//  Copyright © 2020 David Trejo. All rights reserved.
//

import Foundation

class NpsResource: ApiResource {
    typealias Model = [Nps.CodingData]
    
    let urlRequest: URLRequest
    
    init() {
        var urlBuilder = Endpoint.kinedu
        urlBuilder.path += "/bi/nps"
        guard let url = urlBuilder.url else { fatalError("Invalid URL") }
        urlRequest = URLRequest(url: url, apiKey: ApiKey.demoApiKey, httpMethod: .get)
    }
    
    func makeModel(fromData data: Data) throws -> Model {
        let jsonDecoder = JSONDecoder()
        return try jsonDecoder.decode(Model.self, from: data)
    }
}
