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
    var appCoordinator: AppCoordinatorProtocol?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let winScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: winScene)
        window.overrideUserInterfaceStyle = .light

        let appCoordinator = AppCoordinator()

        window.backgroundColor = .white
        window.makeKeyAndVisible()
        self.window = window
        self.appCoordinator = appCoordinator

        self.appCoordinator?.start()
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

}
