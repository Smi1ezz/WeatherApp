//
//  LocationManager.swift
//  WeatherApp
//
//  Created by admin on 11.05.2022.
//

import CoreLocation
import Foundation

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()

    private let manager = CLLocationManager()
    private var complition: ((CLLocation) -> Void)?

    func getUserLocation(complition: @escaping ((CLLocation) -> Void)) {
        self.complition = complition
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        complition?(location)
        manager.stopUpdatingLocation()
    }

}
