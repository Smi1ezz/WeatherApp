//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by admin on 06.05.2022.
//

import Foundation

protocol WeatherNetworkManagerProtocol {
    func fetchDataModelType<T: Codable>(endpoint: EndpointCases, modelType: T.Type, complition: @escaping (ObtainResults) -> Void)
}

enum ObtainResults {
    case success(result: [Codable])
    case failure(error: Error)
}

class WeatherNetworkManager: WeatherNetworkManagerProtocol {
    private let session = URLSession.shared
    private let decoder = JSONDecoder()

    static let shared = WeatherNetworkManager()

    func fetchDataModelType<T: Codable>(endpoint: EndpointCases, modelType: T.Type, complition: @escaping (ObtainResults) -> Void) {

        guard let url = endpoint.URL else {
            return
        }

        session.dataTask(with: url) { [weak self] data, _, error in
            var result: ObtainResults

            defer {
                DispatchQueue.main.async {
                    complition(result)
                }
            }

            guard let strongSelf = self else {
                let error = NSError(domain: "NeteorkManager", code: 412, userInfo: ["Error. Session.dataTask has no owner": ""])
                result = .failure(error: error)
                return
            }

            if error == nil, let parsData = data {
                do {
                    let resultOfRequest = try strongSelf.decoder.decode(modelType.self, from: parsData)
                    print("Получена модель \(modelType)")
                    result = .success(result: [resultOfRequest])
                } catch {
                    result = .failure(error: error)
                }
            } else {
                result = .failure(error: error!)
            }
        }
        .resume()
    }

}
