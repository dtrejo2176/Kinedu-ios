//
//  ApiResource.swift
//  KineduPOC
//
//  Created by David Trejo on 3/27/20.
//  Copyright © 2020 David Trejo. All rights reserved.
//

import Foundation

protocol ApiResource {
    associatedtype Model
    var urlRequest: URLRequest { get }
    func makeModel(fromData data: Data) throws -> Model
}

extension ApiResource where Self.Model: Decodable {
    func makeModel(fromData data: Data) throws -> Model {
        let decored = JSONDecoder()
        decored.keyDecodingStrategy = .convertFromSnakeCase
        return try decored.decode(Model.self, from: data)
    }
}

extension ApiResource where Self.Model: EmptyNetworkResult {
    func makeModel(fromData data: Data) throws -> EmptyNetworkResult {
        return EmptyNetworkResult()
    }
}
