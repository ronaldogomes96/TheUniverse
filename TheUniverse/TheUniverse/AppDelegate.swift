//
//  AppDelegate.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 13/07/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions:
                    [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    //Acionado quando o app esta prestes a ir para o espaco
    /*func applicationWillTerminate(_ application: UIApplication) {

        //swiftlint:disable line_length
        let scene = application.connectedScenes.first?.delegate as? SceneDelegate
        guard let tabBar = scene?.window?.rootViewController as? UITabBarController,
            let nav = tabBar.selectedViewController as? UINavigationController, let controller = nav.topViewController as? CelestialBodyDescriptionViewController else{
            return
        }
        print("Funcionou")
        let name = controller.celestialBodyName
        UserDefaults.standard.set(name,
                                  forKey: "Celestial Body Name")
        //_ = UserDefaults.synchronize(UserDefaults.standard)
    }*/
}
