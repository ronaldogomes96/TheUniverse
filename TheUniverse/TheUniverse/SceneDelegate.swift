//
//  SceneDelegate.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 13/07/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
// swiftlint:disable line_length

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window?.windowScene = windowScene
        
        let isFirstSreen = (UserDefaults.standard.bool(forKey: "FirstLaunch"))
        if !isFirstSreen {
            UserDefaults.standard.set(true, forKey: "FirstLaunch")
            self.window?.rootViewController = OnBoardingViewController()
        }
        else {
            let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
            let controller = storyboard.instantiateInitialViewController()
            self.window?.rootViewController = controller
        }
        
        self.window?.makeKeyAndVisible()
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
