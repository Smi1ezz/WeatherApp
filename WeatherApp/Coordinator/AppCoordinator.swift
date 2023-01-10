//
//  AppCoordinator.swift
//  WeatherApp
//
//  Created by admin on 07.01.2023.
//

import Foundation
import UIKit

protocol AppCoordinatorProtocol {
    func start()
}

final class AppCoordinator: AppCoordinatorProtocol {
    var naviVC: UINavigationController?

    deinit {
        print("AppCoordinator deinit")
    }

    func start() {
        if UserDefaults.standard.bool(forKey: UserDefaultsKeys.onboardingCompleted.rawValue) {
            showMainVC()
        } else {
            showOnboardingVC()
        }

        guard let delegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }

        delegate.window?.rootViewController = naviVC
    }

    private func showOnboardingVC() {
        let onboardingPresenter = OnboardingPresenter()
        let onboardingVC = OnboardingViewController(presenter: onboardingPresenter)
        naviVC = UINavigationController(rootViewController: onboardingVC)
        naviVC?.isNavigationBarHidden = true
    }

    private func showMainVC() {
        let networkManager = WeatherNetworkManager()
        let locationManager = LocationManager()
        let coordinator = MainCoordinator()
        let mainWeatherPresenter = MainWeatherPresenter(coordinator: coordinator,
                                                        netWorkManager: networkManager,
                                                        locationManager: locationManager)
        let mainVC = MainViewController(presenter: mainWeatherPresenter)
        naviVC = UINavigationController(rootViewController: mainVC)
        naviVC?.isNavigationBarHidden = false
        coordinator.setNavigation(controller: naviVC)
    }

}
