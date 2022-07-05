//
//  LocationModel.swift
//  WeatherApp
//
//  Created by admin on 01.06.2022.

//  использую API геокодер https://geocode-maps.yandex.ru

import Foundation

struct LocationModel: Codable {
    let response: GeoObjectCollectionModel

}

struct GeoObjectCollectionModel: Codable {
    let geoObjectCollection: FeatureMemberModel

    enum CodingKeys: String, CodingKey {
        case geoObjectCollection = "GeoObjectCollection"
    }
}

struct FeatureMemberModel: Codable {
    let featureMember: [GeoObjectModel]
}

struct GeoObjectModel: Codable {
    let geoObject: PointModel

    enum CodingKeys: String, CodingKey {
        case geoObject = "GeoObject"
    }
}

struct PointModel: Codable {
    let point: PositionModel

    enum CodingKeys: String, CodingKey {
        case point = "Point"
    }
}

struct PositionModel: Codable {
    let pos: String
}
