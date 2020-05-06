//
//  NetworkRequest.swift
//  KineduPOC
//
//  Created by David Trejo on 3/27/20.
//  Copyright © 2020 David Trejo. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case serverError(code: Int, data: Data?)
    case nilData
    case decodeFail(Error?)
    case connectionError
}

extension NetworkError: LocalizedError {

    private enum Strings {
        static let serverError = "There has been a server error"
        static let emptyContentError = "Response is empty"
        static let invalidFormatError = "Response has an invalid format"
    }
    
    var errorDescription: String? {
        switch self {
        case let .serverError(code, data):
            if let data = data, let content = String(data: data, encoding: .utf8) {
                return "Error \(code) - \(content)"
            } else {
                return "Error \(code) - \(Strings.serverError)"
            }
        case .nilData:
            return Strings.emptyContentError
        case .decodeFail(let underlying):
            return underlying?.localizedDescription ?? Strings.invalidFormatError
        case .connectionError:
            return ""
        }
    }
}

class EmptyNetworkResult { }

protocol NetworkRequest {
    associatedtype LoadedType
    
    func load(then handler: @escaping (Result<LoadedType, Error>) -> Void) -> Request
    func decode(_ data: Data) throws -> LoadedType
}

extension NetworkRequest where Self.LoadedType: EmptyNetworkResult {
    @discardableResult
    func load(request: URLRequest, then handler: @escaping (Result<EmptyNetworkResult, Error>) -> Void) -> Request {
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                DispatchQueue.main.async {
                    handler(Result.failure(error!))
                }
                return
            }
            handler(Result.success(EmptyNetworkResult()))
        }
        task.resume()
        return Request(task: task)
    }
}

extension NetworkRequest {
    
    @discardableResult
    func load(request: URLRequest, then handler: @escaping (Result<LoadedType, Error>) -> Void) -> Request {
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                DispatchQueue.main.async {
                    if let noConnectionError = error?.code, noConnectionError == -1009 {
                        handler(Result.failure(NetworkError.connectionError))
                    } else {
                        handler(Result.failure(error!))
                    }
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    handler(Result.failure(NetworkError.nilData))
                }
                return
            }
            do {
                let loadedType = try self.decode(data)
                DispatchQueue.main.async {
                    handler(Result.success(loadedType))
                }
            } catch {
                DispatchQueue.main.async {
                    handler(Result.failure(NetworkError.decodeFail(error)))
                }
            }
        }
        task.resume()
        return Request(task: task)
    }
}
