//
//  LocationModel.swift
//  WeatherApp
//
//  Created by admin on 01.06.2022.

//  использую API геокодер https://geocode-maps.yandex.ru

import Foundation

class LocationModel: Codable {
    let response: GeoObjectCollectionModel

}

class GeoObjectCollectionModel: Codable {
    let geoObjectCollection: FeatureMemberModel

    enum CodingKeys: String, CodingKey {
        case geoObjectCollection = "GeoObjectCollection"
    }
}

class FeatureMemberModel: Codable {
    let featureMember: [GeoObjectModel]
}

class GeoObjectModel: Codable {
    let geoObject: PointModel

    enum CodingKeys: String, CodingKey {
        case geoObject = "GeoObject"
    }
}

class PointModel: Codable {
    let point: PositionModel

    enum CodingKeys: String, CodingKey {
        case point = "Point"
    }
}

class PositionModel: Codable {
    let pos: String
}
