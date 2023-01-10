//
//  DailyPresenter.swift
//  WeatherApp
//
//  Created by admin on 10.01.2023.
//

import Foundation

protocol DailyPresenterProtocol {
    var weather: WeatherModelDaily {get}
    var selecterIndex: Int {get}
    func newIndex(_ index: Int)
}

final class DailyPresenter: DailyPresenterProtocol {
    var weather: WeatherModelDaily
    var selecterIndex: Int

    init(weather: WeatherModelDaily, selectedIndex: Int) {
        self.weather = weather
        self.selecterIndex = selectedIndex
    }

    func newIndex(_ index: Int) {
        selecterIndex = index
    }
}
