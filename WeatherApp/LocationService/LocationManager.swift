//
//  LocationManager.swift
//  WeatherApp
//
//  Created by admin on 11.05.2022.
//

import CoreLocation
import Foundation

protocol LocationManagerProtocol {
    func getLocations(complition: @escaping ([Location]) -> Void)
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

final class LocationManager: NSObject, LocationManagerProtocol, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    private var complition: ((CLLocation) -> Void)?
    private var currentLocation: CLLocation?

    func getLocations(complition: @escaping ([Location]) -> Void) {
        var locations = UserDefaults.standard.object([Location].self,
                                                     with: UserDefaultsKeys.userLocations.rawValue)

        if let locations = locations, !locations.isEmpty {
            complition(locations)
            return
        } else {
            guard checkLocationAvailible() else {
                complition(locations ?? [])
                return
            }

            getUserLocation { location in
                let longitude = Float(location.coordinate.longitude)
                let latitude = Float(location.coordinate.latitude)
                let newLocation = Location(latitude: latitude, longitude: longitude)
                locations?.append(newLocation)
                complition(locations ?? [])
            }

        }
    }

    private func getUserLocation(complition: @escaping ((CLLocation) -> Void)) {
        self.complition = complition
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
    }

    private func checkLocationAvailible() -> Bool {
        return UserDefaults.standard.bool(forKey: UserDefaultsKeys.locationAvailible.rawValue)
    }

    // MARK: CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first, currentLocation == nil else { return }
        currentLocation = location
        complition?(location)
        manager.stopUpdatingLocation()
    }

}
