//
//  Endpoint.swift
//  WeatherApp
//
//  Created by admin on 28.06.2022.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var parameters: [URLQueryItem] { get }
    var URL: URL? { get }
}

enum EndpointCases: Endpoint {
    case getData(fromLocation: Localizable)
    case getLocation(cityName: String)

    var scheme: String {
        switch self {
        case .getData:
            return "https"
        case .getLocation:
            return "https"
        }
    }

    var host: String {
        switch self {
        case .getData:
            return "ru.api.openweathermap.org"
        case .getLocation:
            return "geocode-maps.yandex.ru"
        }
    }

    var path: String {
        switch self {
        case .getData:
            return "/data/2.5/onecall"
        case .getLocation:
            return "/1.x"
        }
    }

    var parameters: [URLQueryItem] {
        switch self {
        case .getData(let located):
            return [
                URLQueryItem(name: "appid", value: "ad391060e009484099ee82b70b929765"),
                URLQueryItem(name: "units", value: "metric"),
                URLQueryItem(name: "lang", value: "ru"),
                URLQueryItem(name: "lat", value: "\(String(located.latitude))"),
                URLQueryItem(name: "lon", value: "\(String(located.longitude))")
            ]
        case .getLocation(let city):
            return [
                URLQueryItem(name: "format", value: "json"),
                URLQueryItem(name: "apikey", value: "92537361-aa36-44d0-aae9-c594b9635376"),
                URLQueryItem(name: "geocode", value: "\(city)")
            ]
        }
    }

    var URL: URL? {
        switch self {
        case .getData:
            return makeURL()
        case .getLocation:
            return makeURL()
        }
    }

    private func makeURL() -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = self.scheme
        urlComponents.host = self.host
        urlComponents.path = self.path
        let quoryItems = self.parameters
        urlComponents.queryItems = quoryItems
        let newURL = urlComponents.url
        return newURL
    }
}
