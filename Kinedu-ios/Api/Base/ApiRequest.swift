//
//  ApiRequest.swift
//  KineduPOC
//
//  Created by David Trejo on 3/27/20.
//  Copyright © 2020 David Trejo. All rights reserved.
//

import Foundation

struct ApiRequestErrorData {
    let errorCode: Int
    let errorMessage: String
}

struct ApiRequest<Resource: ApiResource> {
    let resource: Resource
}

extension ApiRequest: NetworkRequest {
    
    typealias LoadedType = Resource.Model
    
    @discardableResult
    func load(then handler: @escaping (Result<LoadedType, Error>) -> Void) -> Request {
        return self.load(request: resource.urlRequest, then: handler)
    }
    
    func decode(_ data: Data) throws -> Resource.Model {
        return try resource.makeModel(fromData: data)
    }
}
