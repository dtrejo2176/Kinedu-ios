//
//  ApiService.swift
//  KineduPOC
//
//  Created by David Trejo on 3/27/20.
//  Copyright © 2020 David Trejo. All rights reserved.
//

import Foundation

enum ApiServiceError: Error {
    case apiError(code: String?, name: String?, message: String)
}

extension ApiServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .apiError(_, _, message: let message):
            return message
        }
    }
}

protocol ApiServiceDelegate: class {
    func apiServiceDidRecieveUnauthorizedError(_ apiService: ApiService, retryHandler: @escaping () -> Void)
    func apiServiceRequiresAccessTokenUpdate(_ apiService: ApiService, retryHandler: @escaping () -> Void)
}

class ApiService {
    weak var delegate: ApiServiceDelegate?
}

extension ApiService {
    private struct ApiServiceErrorCodingData: Decodable {
        let error: ErrorData
        
        struct ErrorData: Decodable {
            let code: Int?
            let name: String?
            let message: String
        }
    }
    
    private struct ApiServiceRawErrorCodingData: Decodable {
        let errorCode: String
        let errorMessage: String
    }
    
    private struct ApiServiceRawDescriptionErrorCodingData: Decodable {
        let error: String
        let errorDescription: String
    }
    
    private struct ApiServiceResultErrorCodingData: Decodable {
        let resultCode: Int
        let resultMessage: String
    }
    
    func perform<Resource>(request: ApiRequest<Resource>, then handler: @escaping (Result<Resource.Model, Error>) -> Void) {
        request.load() { [unowned self] response in
            if case .failure(let error) = response, case NetworkError.serverError(code: let code, _) = error, code == 401 {
                self.delegate?.apiServiceDidRecieveUnauthorizedError(self) { [weak self] in
                   self?.perform(request: request, then: handler)
                }
            } else if case .failure(let error) = response, case NetworkError.serverError(code: let code, data: let data) = error, let errorData = data {
                if ((400 ..< 500) ~= code), let error = self.error(fromData: errorData) {
                    handler(.failure(error))
                } else {
                    handler(response)
                }
            } else {
                handler(response)
            }
        }
    }
    
}

private extension ApiService {
    func error(fromData data: Data) -> Error? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        if let errorData = try? decoder.decode(ApiServiceErrorCodingData.self, from: data) {
            if let underlyingData = errorData.error.message.data(using: .utf8), let error = error(fromData: underlyingData) {
                return error
            } else {
                return ApiServiceError.apiError(code: "\(errorData.error.code ?? -1)", name: errorData.error.name, message: errorData.error.message)
            }
        } else if let errorData = try? decoder.decode(ApiServiceRawErrorCodingData.self, from: data) {
            if let underlyingData = errorData.errorMessage.data(using: .utf8), let error = error(fromData: underlyingData) {
                return error
            } else {
                return ApiServiceError.apiError(code: errorData.errorCode, name: nil, message: errorData.errorMessage)
            }
        } else if let errorData = try? decoder.decode(ApiServiceRawDescriptionErrorCodingData.self, from: data) {
            if let underlyingData = errorData.errorDescription.data(using: .utf8), let error = error(fromData: underlyingData) {
                return error
            } else {
                return ApiServiceError.apiError(code: errorData.error, name: nil, message: errorData.errorDescription)
            }
        } else if let errorData = try? decoder.decode([ApiServiceRawDescriptionErrorCodingData].self, from: data) {
            guard let error = errorData.first else { return nil }
            return ApiServiceError.apiError(code: error.error, name: nil, message: error.errorDescription)
        } else {
            decoder.keyDecodingStrategy = .useDefaultKeys
            if let errorData = try? decoder.decode(ApiServiceResultErrorCodingData.self, from: data) {
                return ApiServiceError.apiError(code: "\(errorData.resultCode)", name: nil, message: errorData.resultMessage)
            } else {
                return nil
            }
        }
    }
}
