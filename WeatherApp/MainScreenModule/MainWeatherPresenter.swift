//
//  WeatherInfoStore.swift
//  WeatherApp
//
//  Created by admin on 31.03.2022.
//

import Foundation

protocol MainWeatherPresenterDelegate: AnyObject {
    func reload()
    func startSpinner()
    func stopSpinner()
    func showWarning(error: String)
}

protocol StoragablePresenter {
    var storage: [[WeatherModelDaily]]? {get}
}

protocol LocationablePresenter {
    var locations: [Location]? {get}
    func fetchLocation(ofCity name: String, complition: @escaping () -> Void)
}

protocol CoordinatablePresenter {
    var coordinator: MainCoordinatorProtocol {get}
}

protocol MainWeatherPresenterProtocol: StoragablePresenter, LocationablePresenter, CoordinatablePresenter {
    func setPresented(viewController: MainWeatherPresenterDelegate)
    func fetchWeather()
}

final class MainWeatherPresenter: MainWeatherPresenterProtocol {

    private let netWorkManager: WeatherNetworkManagerProtocol
    private let locationManager: LocationManagerProtocol

    weak var presentedVC: MainWeatherPresenterDelegate?

    var coordinator: MainCoordinatorProtocol
    var locations: [Location]? {
        didSet {
            UserDefaults.standard.set(object: locations, forKey: UserDefaultsKeys.userLocations.rawValue)
        }
    }

    var storage: [[WeatherModelDaily]]?

    init(coordinator: MainCoordinatorProtocol, netWorkManager: WeatherNetworkManagerProtocol, locationManager: LocationManagerProtocol) {
        self.coordinator = coordinator
        self.netWorkManager = netWorkManager
        self.locationManager = locationManager
        self.storage = []
    }

    func setPresented(viewController: MainWeatherPresenterDelegate) {
        presentedVC = viewController
    }

    func fetchWeather() {
        guard let locations = locations, !locations.isEmpty else {
            locationManager.getLocations { [weak self] locations in
                self?.locations = locations
                self?.presentWeatherFrom(locations: locations)
            }
            return
        }
        presentWeatherFrom(locations: locations)
    }

    func fetchLocation(ofCity name: String, complition: @escaping () -> Void) {
        netWorkManager.fetchDataModelType(endpoint: .getLocation(cityName: name), modelType: LocationModel.self) {[weak self] result in
            switch result {
            case .success(let location):
                if let location = location.first as? LocationModel {
                    guard let featureMember = location.response.geoObjectCollection.featureMember.first else {
                        complition()
                        return
                    }
                    let positionString = featureMember.geoObject.point.pos
                    let lonAndLat = positionString.components(separatedBy: " ").map { Float($0) ?? 0 }

                    guard let long = lonAndLat.first, let lat = lonAndLat.last else {
                        complition()
                        return
                    }

                    let userData = UserDefaults.standard
                    if !userData.bool(forKey: UserDefaultsKeys.locationAvailible.rawValue) {
                        userData.set(true, forKey: UserDefaultsKeys.locationAvailible.rawValue)
                    }

                    let location = Location(latitude: lat, longitude: long)
                    print("longitude \(location.longitude), latitude \(location.latitude)")
                    self?.locations?.append(location)
                    self?.presentWeatherFrom(locations: [location])
                    complition()
                } else {
                    self?.presentedVC?.showWarning(error: "SOME another Type in result")
                }
            case .failure(let error):
                self?.presentedVC?.showWarning(error: error.localizedDescription)
            }
        }
    }

    private func presentWeatherFrom(locations: [Location]) {
        let group = DispatchGroup()
        presentedVC?.startSpinner()

        locations.forEach { location in
            group.enter()
            fetchWeather(inCity: location) { [weak self] weather in
                guard !weather.isEmpty else {
                    group.leave()
                    return
                }
                self?.storage?.append(weather)
                group.leave()
            }
        }

        group.notify(queue: .main) { [weak self] in
            self?.presentedVC?.stopSpinner()
            self?.presentedVC?.reload()
        }
    }

    private func fetchWeather(inCity city: Localizable, complition: @escaping ([WeatherModelDaily]) -> Void) {
        netWorkManager.fetchDataModelType(endpoint: .getData(fromLocation: city), modelType: WeatherModelDaily.self) { [weak self] result in
            let weatherModels: [WeatherModelDaily]

            defer {
                complition(weatherModels)
            }

            switch result {
            case .success(let weather):
                guard let weather = weather as? [WeatherModelDaily], !weather.isEmpty else {
                    weatherModels = []
                    return
                }
                weatherModels = weather
            case .failure(let error):
                self?.presentedVC?.showWarning(error: error.localizedDescription)
                weatherModels = []
            }
        }
    }
}
