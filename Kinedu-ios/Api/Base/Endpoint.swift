//
//  Endpoint.swift
//  KineduPOC
//
//  Created by David Trejo on 3/27/20.
//  Copyright © 2020 David Trejo. All rights reserved.
//

import Foundation

enum Endpoint {
    static var kinedu: URLComponents{
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "demo.kinedu.com"
        return urlComponents
    }
    
}
