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
    func showSettingsVC()
    func showDailySummaryVC(withWeather weather: WeatherModelDaily, selectedIndex: Int)
    func showTwentyFourHoursVC(withWeather weather: WeatherModelDaily)
}

final class MainCoordinator: MainCoordinatorProtocol {
    private weak var naviVC: UINavigationController?

    func setNavigation(controller: UINavigationController?) {
        self.naviVC = controller
    }

    func showSettingsVC() {
        naviVC?.pushViewController(SettingsViewController(), animated: true)
    }

    func showDailySummaryVC(withWeather weather: WeatherModelDaily, selectedIndex: Int) {
        let viewController = DailySummaryViewController()
        viewController.setWeather(weather)
        viewController.selectedDateIndex = selectedIndex
        naviVC?.pushViewController(viewController, animated: true)
    }

    func showTwentyFourHoursVC(withWeather weather: WeatherModelDaily) {
        let viewController = TwentyFourHoursViewController()
        viewController.setWeather(weather)
        naviVC?.pushViewController(viewController, animated: true)
    }

}
