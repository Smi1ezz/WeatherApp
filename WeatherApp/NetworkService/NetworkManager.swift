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
                result = .success(weather: [])
                print("\(String(describing: error?.localizedDescription))")
                return
            }

            if error == nil, let parsData = data {
                guard let weather = try? strongSelf.decoder.decode(TestWeatherModelDaily.self, from: parsData) else {
                    print("Модель TestWeatherModelDaily не спарсилась. Будет пустой массив.Но получил data \(parsData)")
                    result = .success(weather: [])
                    return
                }
                print("Модель TestWeatherModelDaily успешно спарсилась")
                result = .success(weather: [weather])
            } else {
                result = .failure(error: error!)
                print("\(String(describing: error?.localizedDescription))")
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
                result = .success(location: [])
                print("ERROR \(String(describing: error?.localizedDescription))")
                return
            }

            if error == nil, let parsData = data {
                guard let location = try? strongSelf.decoder.decode(LocationModel.self, from: parsData) else {
                    print("Модель LocationModel не спарсилась. Будет пустой массив. Но получил data \(parsData)")
                    result = .success(location: [])
                    return
                }
                print("Модель LocationModel успешно спарсилась")
                result = .success(location: [location])
            } else {
                result = .failure(error: error!)
                print("ERROR \(String(describing: error?.localizedDescription))")
            }
        }
        .resume()
    }

}
