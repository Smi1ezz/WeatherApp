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
    var storage: [[TestWeatherModelDaily]] {get}
    var locations: [Location] {get set}
    var netWorkManager: WeatherNetworkManagerProtocol {get set}

    func fetchWeather()
}

protocol Locolizable {
    var latitude: Float {get set} // широта
    var longitude: Float {get set} // долгота
}

struct Location: Locolizable, Codable {
    var latitude: Float
    var longitude: Float
}

protocol WeatherInfoDelegate: AnyObject {
    func refresh(model: WeatherInfoModelProtocol)
}

class WeatherInfoModel: WeatherInfoModelProtocol {

    weak var delegate: WeatherInfoDelegate?

    var netWorkManager: WeatherNetworkManagerProtocol

    var locations: [Location] = {
        let userData = UserDefaults.standard
        let locations = userData.object([Location].self, with: UserDefaultsKeys.userLocations.rawValue)
        guard let lctns = locations else {
            return [Location]()
        }
        print("USERDATA LOCATIONS count \(lctns.count)")

        return lctns
    }()

    var storage = [[TestWeatherModelDaily]]()

    init(netWorkManager: WeatherNetworkManagerProtocol) {
        self.netWorkManager = netWorkManager
    }

    func fetchWeather() {
        if locations.isEmpty {
            let userData = UserDefaults.standard
            if userData.bool(forKey: UserDefaultsKeys.locationAvailible.rawValue) {
                print("fetchWeather определение локации было разрешено")

                    LocationManager.shared.getUserLocation { [weak self] location in
                        var newLocation = Location(latitude: 0, longitude: 0)
                        newLocation.longitude = Float(location.coordinate.longitude)
                        newLocation.latitude = Float(location.coordinate.latitude)

                        guard let strongSelf = self else {
                            return
                        }
                        strongSelf.addLocation(newLocation)
                        strongSelf.startFetchWeather()
                }
            }
        } else {
            startFetchWeather()
        }
    }

    func addLocation(_ location: Location) {
        locations.append(location)

        let userData = UserDefaults.standard
        userData.set(object: locations, forKey: UserDefaultsKeys.userLocations.rawValue)
    }

    func startFetchWeather() {
        guard !locations.isEmpty else {
            print("warning! locations is empty. Add Locations")
            return
        }

        for (index, location) in locations.enumerated() {
            netWorkManager.fetchData(located: location) {[weak self] (result) in

                guard let strongSelf = self else {
                    return
                }

                switch result {
                case .success(let weather):
                    if strongSelf.storage.count <= index && (index - strongSelf.storage.count) < 1 {
                        strongSelf.storage.insert(weather, at: index)
                    } else if strongSelf.storage.count <= index && (index - strongSelf.storage.count) >= 1 {
                        while strongSelf.storage.count != index {
                            strongSelf.storage.append(weather)
                        }
                        strongSelf.storage.insert(weather, at: index)
                    } else if strongSelf.storage.count > index {
                        strongSelf.storage[index] = weather
                    }
                    strongSelf.delegate?.refresh(model: strongSelf)

                case .failure(let error):
                    print("Error \(error.localizedDescription)")
                }
            }
        }
    }
}
