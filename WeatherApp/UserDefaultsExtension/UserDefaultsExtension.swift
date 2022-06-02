//
//  UserDefaultsExtension.swift
//  WeatherApp
//
//  Created by admin on 24.05.2022.
//

import Foundation

enum UserDefaultsKeys: String {
    case locationAvailible // bool
    case userLocations // хранит массив добавленных локаций. По умолчанию [Locations]()
    case onboardingCompleted // bool

    case temperatureCelsius // bool
    case speedMi // bool
    case timeTwentyFourHours // bool
    case notificationsOn // bool
}

extension UserDefaults {
    func object<T: Codable>(_ type: T.Type, with key: String, usingDecoder decoder: JSONDecoder = JSONDecoder()) -> T? {
        guard let data = self.value(forKey: key) as? Data else { return nil }
        return try? decoder.decode(type.self, from: data)
    }

    func set<T: Codable>(object: T, forKey key: String, usingEncoder encoder: JSONEncoder = JSONEncoder()) {
        let data = try? encoder.encode(object)
        self.set(data, forKey: key)
    }
}
