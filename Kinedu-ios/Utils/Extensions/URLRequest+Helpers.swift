//
//  URLRequest+Helpers.swift
//  KineduPOC
//
//  Created by David Trejo on 3/27/20.
//  Copyright © 2020 David Trejo. All rights reserved.
//

import Foundation

extension URLRequest {
    
    init(url: URL, apiKey: String, httpMethod: HTTPMethod = .get) {
        self.init(url: url)
        setValue(apiKey, forHTTPHeaderField: "ApiKey")
        self.httpMethod = httpMethod.rawValue
    }
    
    mutating func setHTTPBody<DataType: Encodable>(withJsonFrom encodable: DataType, toSnakeCase: Bool = true) {
        setValue("application/json", forHTTPHeaderField: "content-type")
        let encoder = JSONEncoder()
        if toSnakeCase {
            encoder.keyEncodingStrategy = .convertToSnakeCase
        }
        do {
            httpBody = try encoder.encode(encodable)
        } catch {
            fatalError("Unable to encode data")
        }
    }
}
