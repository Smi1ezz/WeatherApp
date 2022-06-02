//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by admin on 06.05.2022.
//

import Foundation
// import UIKit

protocol WeatherNetworkManagerProtocol {
    func fetchData(located: Locolizable,
                   complition: @escaping (ObtainWeatherResults) -> Void)
    func fetchLocationOfCity(named cityName: String, complition: @escaping (ObtainLocationResults) -> Void)
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

    func fetchData(located: Locolizable,
                   complition: @escaping (ObtainWeatherResults) -> Void) {

        let adressUrl = "https://ru.api.openweathermap.org/data/2.5/onecall?"

        let location = {
            "lat=\(String(located.latitude))&lon=\(String(located.longitude))"
        }()
        let appid = "&appid=ad391060e009484099ee82b70b929765"
        let unitsParameter = "&units=metric"
        let langParameter = "&lang=ru"

        func makeURL() -> URL? {
            let finalAdress = adressUrl+location+unitsParameter+langParameter+appid
            let finalUrl = URL(string: finalAdress)
            return finalUrl
        }

        guard let safeUrl = makeURL() else {
            return
        }

        session.dataTask(with: safeUrl) { [weak self] data, _, error in
            var result: ObtainWeatherResults

            defer {
                DispatchQueue.main.sync {
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
                    print("Модель не спарсилась. Будет пустой массив")
                    print("Но получил data \(parsData)")
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

    func fetchLocationOfCity(named cityName: String, complition: @escaping (ObtainLocationResults) -> Void) {

        func makeURL() -> URL? {
            let adress = "https://geocode-maps.yandex.ru/1.x/?format=json"
            let appKey = "&apikey=92537361-aa36-44d0-aae9-c594b9635376"
            let cityName = "&geocode=" + cityName
            let url = adress+appKey+cityName
            let finalURL = URL(string: url)

            return finalURL
        }

        guard let url = makeURL() else {
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
                    print("Модель не спарсилась. Будет пустой массив")
                    print("Но получил data \(parsData)")
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
