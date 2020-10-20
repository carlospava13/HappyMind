//
//  BaseAPIClient.swift
//  HappyMindData
//
//  Created by Carlos Pava on 14/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Combine
import Alamofire

final public class BaseAPIClient: BaseAPIClientType {

    public init() { }

    public func request<Response: Codable>(_ endpoint: Endpoint) -> AnyPublisher<Response, Error> {
        Future<Response, Error> { promisse in

            guard let url = self.getBaseUrl(endpoint.relativePath) else {
                promisse(.failure(DifferentError.malformedURL))
                return
            }

            AF.request(url,
                method: endpoint.method,
                parameters: endpoint.parameters,
                encoding: endpoint.parameterEncoding,
                headers: nil).responseData { (response) in
                switch response.result {
                case.success(let data):
                    do {
                        let responseData = try JSONDecoder().decode(Response.self, from: data)
                        promisse(.success(responseData))
                    } catch {
                        promisse(.failure(DifferentError.malformedURL))
                    }

                case .failure(let error):
                    promisse(.failure(DifferentError.alamofire(wrapped: error)))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    private func getBaseUrl(_ path: String) -> URL? {
          let formattedURL = URL(string: BaseAPIConstants.baseURL)
          return formattedURL?.appendingPathComponent(path)
      }
}
