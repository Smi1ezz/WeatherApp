//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by admin on 06.05.2022.
//

import Foundation

protocol WeatherNetworkManagerProtocol {
    func fetchData(endpoint: EndpointCases, complition: @escaping (ObtainWeatherResults) -> Void)
    func fetchLocationOfCity(endpoint: EndpointCases, complition: @escaping (ObtainLocationResults) -> Void)
}

enum ObtainWeatherResults {
    case success(weather: [TestWeatherModelDaily])
    case failure(error: Error)
}

enum ObtainLocationResults {
    case success(location: [LocationModel])
    case failure(error: Error)
}

enum ObtainResults {
    case success(result: [Codable])
    case failure(error: Error)
}

class WeatherNetworkManager: WeatherNetworkManagerProtocol {
    private let sessionConfiguration = URLSessionConfiguration.default
    private let session = URLSession.shared
    private let decoder = JSONDecoder()

    static let shared = WeatherNetworkManager()

    func fetchData(endpoint: EndpointCases, complition: @escaping (ObtainWeatherResults) -> Void) {

        guard let safeURL = endpoint.URL else {
            return
        }

        session.dataTask(with: safeURL) { [weak self] data, _, error in
            var result: ObtainWeatherResults

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
                    let weather = try strongSelf.decoder.decode(TestWeatherModelDaily.self, from: parsData)
                    print("Модель TestWeatherModelDaily успешно спарсилась")
                    result = .success(weather: [weather])
                } catch {
                    result = .failure(error: error)
                }
            } else {
                result = .failure(error: error!)
            }
        }
        .resume()
    }

    func fetchLocationOfCity(endpoint: EndpointCases, complition: @escaping (ObtainLocationResults) -> Void) {

        guard let url = endpoint.URL else {
            return
        }

        session.dataTask(with: url) { [weak self] data, _, error in
            var result: ObtainLocationResults

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
                    let location = try strongSelf.decoder.decode(LocationModel.self, from: parsData)
                    print("Модель LocationModel успешно спарсилась")
                    result = .success(location: [location])
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
