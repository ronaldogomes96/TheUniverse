import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    static let onboardingKey = "HasSeenOnboarding"

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        let hasSeenOnboarding = UserDefaults.standard.bool(forKey: SceneDelegate.onboardingKey)
        if hasSeenOnboarding {
            showHome(animated: false)
        } else {
            showOnboarding(animated: false)
        }
        window?.makeKeyAndVisible()
    }

    func showOnboarding(animated: Bool = true) {
        setRootViewController(OnBoardingViewController(), animated: animated)
    }

    func showHome(animated: Bool = true) {
        markOnboardingAsSeen()
        setRootViewController(HomeViewController(), animated: animated)
    }

    func showMainInterface(selectedTab: Int? = nil, animated: Bool = true) {
        let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
        guard let controller = storyboard.instantiateInitialViewController() as? UITabBarController else {
            return
        }
        if let selectedTab, selectedTab < (controller.viewControllers?.count ?? 0) {
            controller.selectedIndex = selectedTab
        }
        setRootViewController(controller, animated: animated)
    }

    private func setRootViewController(_ viewController: UIViewController, animated: Bool) {
        guard animated, let window = window else {
            window?.rootViewController = viewController
            window?.makeKeyAndVisible()
            return
        }

        UIView.transition(with: window, duration: 0.4, options: [.transitionCrossDissolve], animations: {
            window.rootViewController = viewController
        }, completion: nil)
    }

    private func markOnboardingAsSeen() {
        UserDefaults.standard.set(true, forKey: SceneDelegate.onboardingKey)
    }

    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
}
