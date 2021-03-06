//
//  WeatherInfoStore.swift
//  WeatherApp
//
//  Created by admin on 31.03.2022.
//

import Foundation
import UIKit
import CoreLocation

protocol WeatherInfoModelProtocol {
    var storage: [[WeatherModelDaily]] {get}
    var locations: [Location] {get set}

    func fetchWeather(inCity city: Localizable, complition: @escaping (Swift.Result<[WeatherModelDaily], Error>) -> Void)
    func fetchFirstLocation(complition: @escaping (Localizable) -> Void)
    func addLocation(_ location: Location)
}

protocol Localizable {
    /// широта
    var latitude: Float {get set}
    /// долгота
    var longitude: Float {get set}
}

struct Location: Localizable, Codable {
    var latitude: Float
    var longitude: Float
}

class WeatherInfoModel: WeatherInfoModelProtocol {

    private var netWorkManager: WeatherNetworkManagerProtocol
    var locations: [Location] = {
        let userData = UserDefaults.standard
        let locations = userData.object([Location].self, with: UserDefaultsKeys.userLocations.rawValue)
        guard let lctns = locations else {
            return [Location]()
        }
        print("USERDATA LOCATIONS count \(lctns.count)")
        return lctns
    }()
    var storage = [[WeatherModelDaily]]()

    init(netWorkManager: WeatherNetworkManagerProtocol) {
        self.netWorkManager = netWorkManager
    }

    func fetchWeather(inCity city: Localizable, complition: @escaping (Swift.Result<[WeatherModelDaily], Error>) -> Void) {

        netWorkManager.fetchDataModelType(endpoint: .getData(fromLocation: city), modelType: WeatherModelDaily.self) { [weak self] result in
            switch result {
            case .success(let weather):
                if let weather = weather as? [WeatherModelDaily] {
                    guard !weather.isEmpty else {
                        return
                    }
                    self?.storage.append(weather)
                    complition(.success(weather))
                } else {
                    print("SOME another Type in result")
                }
            case .failure(let error):
                complition(.failure(error))
            }
        }
    }

    func fetchFirstLocation(complition: @escaping (Localizable) -> Void) {
        let userData = UserDefaults.standard
        if userData.bool(forKey: UserDefaultsKeys.locationAvailible.rawValue) {
            if locations.isEmpty {
                    LocationManager.shared.getUserLocation { [weak self] location in
                        var newLocation = Location(latitude: 0, longitude: 0)
                        newLocation.longitude = Float(location.coordinate.longitude)
                        newLocation.latitude = Float(location.coordinate.latitude)

                        guard let strongSelf = self else {
                            return
                        }

                        strongSelf.addLocation(newLocation)
                        complition(newLocation)
                }
            }
        }
    }

    func addLocation(_ location: Location) {
        locations.append(location)
        let userData = UserDefaults.standard
        userData.set(object: locations, forKey: UserDefaultsKeys.userLocations.rawValue)
    }
}
