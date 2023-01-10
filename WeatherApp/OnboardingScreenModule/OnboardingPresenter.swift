//
//  OnboardingPresenter.swift
//  WeatherApp
//
//  Created by admin on 10.01.2023.
//

import Foundation
import UIKit

protocol OnboardingPresenterProtocol {
    func showMainVC()
}

final class OnboardingPresenter: OnboardingPresenterProtocol {
    func showMainVC() {
        if let delegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            delegate.appCoordinator?.start()
        }
    }
}
