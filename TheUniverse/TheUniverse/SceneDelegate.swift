//
//  SceneDelegate.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 13/07/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        //swiftlint:disable line_length
        let scene = scene.delegate as? SceneDelegate
        guard let tabBar = scene?.window?.rootViewController as? UITabBarController,
            let nav = tabBar.selectedViewController as? UINavigationController,
            let controller = nav.topViewController as? CelestialBodyDescriptionViewController else {
            return
        }
        let name = controller.celestialBodyName
        print("Funcionou")
        UserDefaults.standard.set(name, forKey: "Celestial Body Name")
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}
