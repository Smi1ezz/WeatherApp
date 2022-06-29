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
        let router: RouterProtocol = Router()

        self.window = router.makeWinWithStartVC(fromWindow: window)

    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

}
