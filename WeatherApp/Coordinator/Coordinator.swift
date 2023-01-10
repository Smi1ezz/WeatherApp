//
//  Router.swift
//  WeatherApp
//
//  Created by admin on 31.03.2022.
//

import Foundation
import UIKit

protocol MainCoordinatorProtocol: AnyObject {
    func setNavigation(controller: UINavigationController?)
    func showDailySummaryVC(withWeather weather: WeatherModelDaily, selectedIndex: Int)
    func showTwentyFourHoursVC(withWeather weather: WeatherModelDaily)
}

final class MainCoordinator: MainCoordinatorProtocol {
    private weak var naviVC: UINavigationController?

    func setNavigation(controller: UINavigationController?) {
        self.naviVC = controller
    }

    func showDailySummaryVC(withWeather weather: WeatherModelDaily, selectedIndex: Int) {
        let dailyPresenter = DailyPresenter(weather: weather, selectedIndex: selectedIndex)
        let viewController = DailySummaryViewController(presenter: dailyPresenter)
        naviVC?.pushViewController(viewController, animated: true)
    }

    func showTwentyFourHoursVC(withWeather weather: WeatherModelDaily) {
        let twentyFourHourPresenter = TwentyHourPresenter(weather: weather)
        let viewController = TwentyFourHoursViewController(presenter: twentyFourHourPresenter)
        naviVC?.pushViewController(viewController, animated: true)
    }

}
