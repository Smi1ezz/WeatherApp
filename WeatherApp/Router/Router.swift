//
//  Router.swift
//  WeatherApp
//
//  Created by admin on 31.03.2022.
//

import Foundation
import UIKit

protocol RouterProtocol: AnyObject {
    func makeWinWithStartVC(fromWindow window: UIWindow) -> UIWindow
    func showSettingsVC()
    func showDailySummaryVC(withWeather weather: TestWeatherModelDaily, selectedIndex: Int)
    func showTwentyFourHoursVC(withWeather weather: TestWeatherModelDaily)
    func showAddCityAlertVC(onMainVC: MainViewController)
}

class Router: RouterProtocol {
    private var naviVC: UINavigationController?

    convenience init(withNaviVC naviVC: UINavigationController) {
        self.init()
        self.naviVC = naviVC
    }

    func makeWinWithStartVC(fromWindow window: UIWindow) -> UIWindow {
        var firstShowedVC: UIViewController?
        let userData = UserDefaults.standard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        if userData.bool(forKey: UserDefaultsKeys.onboardingCompleted.rawValue) {
            firstShowedVC = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        } else {
            firstShowedVC = storyboard.instantiateViewController(withIdentifier: "Onboarding")
        }

        window.rootViewController = firstShowedVC
        window.backgroundColor = .white
        window.makeKeyAndVisible()
        return window
    }

    func showSettingsVC() {
        naviVC?.pushViewController(SettingsViewController(), animated: true)
    }

    func showDailySummaryVC(withWeather weather: TestWeatherModelDaily, selectedIndex: Int) {
        let viewController = DailySummaryViewController()
        viewController.setWeather(weather)
        viewController.selectedDateIndex = selectedIndex
        naviVC?.pushViewController(viewController, animated: true)
    }

    func showTwentyFourHoursVC(withWeather weather: TestWeatherModelDaily) {
        let viewController = TwentyFourHoursViewController()
        viewController.setWeather(weather)
        naviVC?.pushViewController(viewController, animated: true)
    }

    func showAddCityAlertVC(onMainVC mainVC: MainViewController) {
        let alertVC = UIAlertController(title: "Добавить город",
                                        message: "для добавления, введите название города английскими буквами",
                                        preferredStyle: .alert)

        alertVC.addTextField(configurationHandler: { textField in
            textField.placeholder = "City..."
        })

        alertVC.addAction(UIAlertAction(title: "OK",
                                        style: .default,
                                        handler: { _ in

            if let name = alertVC.textFields?.first?.text {
                print("Новый город: \(name)")

                WeatherNetworkManager.shared.fetchLocationOfCity(named: name) { result in
                    switch result {
                    case .success(let location):
                        let locationString = location[0].response.geoObjectCollection.featureMember[0].geoObject.point.pos
                        let lonAndLat = locationString.components(separatedBy: " ")
                        let long = Float(lonAndLat[0]) ?? 0
                        let lat = Float(lonAndLat[1]) ?? 0

                        let loc = Location(latitude: lat, longitude: long)
                        print("+++ \(loc.longitude), \(loc.latitude)")

                        let userData = UserDefaults.standard
                        if !userData.bool(forKey: UserDefaultsKeys.locationAvailible.rawValue) {
                            userData.set(true, forKey: UserDefaultsKeys.locationAvailible.rawValue)
                        }
                        mainVC.refreshData(withNewCity: loc)
                        mainVC.viewWillAppear(true)

                    case .failure(let error):
                        print("ERROR !!!  \(error.localizedDescription)")
                    }
                }
            }

        }))

        alertVC.addAction(UIAlertAction(title: "Отмена",
                                        style: .cancel,
                                        handler: { _ in
            print("UIAlertAction(title: Отмена)")
        }))

        mainVC.present(alertVC, animated: true)
    }

}
