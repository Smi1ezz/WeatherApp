//
//  TwentyHourPresenter.swift
//  WeatherApp
//
//  Created by admin on 10.01.2023.
//

import Foundation

protocol TwentyHourPresenterProtocol {
    var everyThreeHourWeather: [HourlyWeatherModel] {get}
}

final class TwentyHourPresenter: TwentyHourPresenterProtocol {
    var everyThreeHourWeather = [HourlyWeatherModel]()

    init(weather: WeatherModelDaily) {
        makeEveryThreeHourWeather(weather)
    }

    func makeEveryThreeHourWeather(_ weather: WeatherModelDaily) {
        var hoursCounter = 0
        for _ in 0...8 {
            everyThreeHourWeather.append(weather.hourlyWeather[hoursCounter])
            hoursCounter += 3
        }
    }
}
