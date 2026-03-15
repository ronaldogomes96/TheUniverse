import Foundation
import UIKit
import SwiftUI

final class OnBoardingViewController: UIViewController {
    private lazy var hostingController: UIHostingController<OnboardingFlowView> = {
        let controller = UIHostingController(rootView: OnboardingFlowView { [weak self] in
            self?.showHome()
        })
        controller.view.backgroundColor = .clear
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        hostingController.didMove(toParent: self)
    }

    private func showHome() {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            return
        }
        sceneDelegate.showHome()
    }
}

final class HomeViewController: UIViewController {
    private let viewModel = HomeViewModel()

    private lazy var hostingController: UIHostingController<HomeView> = {
        let controller = UIHostingController(
            rootView: HomeView(
                viewModel: viewModel,
                showExplorer: { [weak self] category in self?.presentExplorer(category: category) },
                showLiveSky: { [weak self] in self?.presentLiveSky() },
                showBodyDetail: { [weak self] bodyID in self?.presentDetail(bodyID: bodyID) }
            )
        )
        controller.view.backgroundColor = .clear
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        hostingController.didMove(toParent: self)
    }

    private func presentExplorer(category: CelestialCategory?) {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        switch category {
        case .planets:
            sceneDelegate.showMainInterface(selectedTab: 0)
        case .satellites:
            sceneDelegate.showMainInterface(selectedTab: 1)
        case .stars:
            sceneDelegate.showMainInterface(selectedTab: 2)
        default:
            sceneDelegate.showMainInterface()
        }
    }

    private func presentLiveSky() {
        let viewModel = LiveSkyViewModel()
        let screen = LiveSkyView(viewModel: viewModel) { [weak self] bodyID in
            self?.presentDetail(bodyID: bodyID)
        }
        let controller = UIHostingController(rootView: screen)
        presentWrapped(controller)
    }

    private func presentDetail(bodyID: CelestialBodyID) {
        viewModel.recordSelection(bodyID)
        let screen = CelestialDetailView(viewModel: CelestialDetailViewModel(bodyID: bodyID)) { [weak self] selectedBody in
            self?.presentLegacy3D(for: selectedBody)
        }
        let controller = UIHostingController(rootView: screen)
        presentWrapped(controller)
    }

    private func presentLegacy3D(for bodyID: CelestialBodyID) {
        let storyboard = UIStoryboard(name: "3DView", bundle: nil)
        guard let controller = storyboard.instantiateInitialViewController() as? Image3DViewController else { return }
        controller.viewModel = Image3DViewModel(name: bodyID.legacyDisplayName)
        presentWrapped(controller)
    }

    private func presentWrapped(_ controller: UIViewController) {
        let navigationController = UINavigationController(rootViewController: controller)
        controller.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissPresented))
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }

    @objc private func dismissPresented() {
        dismiss(animated: true)
    }
}
