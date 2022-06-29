//
//  SceneDelegate.swift
//  WeatherApp
//
//  Created by admin on 29.03.2022.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let winScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: winScene)
        let navigationController = UINavigationController()
        let router: RouterProtocol = Router(withNaviVC: navigationController)
        let userData = UserDefaults.standard

        window.rootViewController = navigationController
        window.backgroundColor = .white
        window.makeKeyAndVisible()
        self.window = window

        if userData.bool(forKey: UserDefaultsKeys.onboardingCompleted.rawValue) {
            router.showMainVC()
        } else {
            router.showOnboardingVC()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

}
