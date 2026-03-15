import UIKit

class CelestialBodyTableViewController: UITableViewController {
    var celestialBodyNames: [String]? {
        didSet { tableView.reloadData() }
    }

    var celestialBodyImageNames: [String]? {
        didSet { tableView.reloadData() }
    }

    private let userCollectionsStore = UserCollectionsStore()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationControllerLayout()
        setupTableViewConfigurations()
        setupHomeButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        celestialBodyNames?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "celestialBodyCell", for: indexPath) as? CelestialBodyTableViewCell else {
            fatalError("Unable to dequeue CelestialBodyTableViewCell")
        }

        cell.celestialBodyName = celestialBodyNames?[indexPath.row]
        cell.celestialBodyImage = UIImage(named: celestialBodyImageNames?[indexPath.row] ?? "")
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let name = celestialBodyNames?[indexPath.row] else { return }
        if let bodyID = CelestialBodyID.from(displayName: name) {
            userCollectionsStore.recordVisit(to: bodyID)
        }

        let celestialBodyData = CelestialBodyDataViewController()
        celestialBodyData.viewModel = CelestialBodyDataViewModel(celestialBodyName: name)
        navigationController?.pushViewController(celestialBodyData, animated: true)
    }

    private func setupNavigationControllerLayout() {
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.defaultGrey]
        navigationController?.navigationBar.barTintColor = .defaultBlack
        navigationController?.navigationBar.isTranslucent = false
    }

    private func setupTableViewConfigurations() {
        view.backgroundColor = .clear
        tableView.backgroundView = UIImageView(image: UIImage(named: "cosmos"))
        tableView.register(CelestialBodyTableViewCell.self, forCellReuseIdentifier: "celestialBodyCell")
        tableView.separatorStyle = .none
    }

    private func setupHomeButton() {
        let homeButton = UIBarButtonItem(title: "Universo", style: .plain, target: self, action: #selector(goToHome))
        homeButton.tintColor = .defaultGreen
        navigationItem.leftBarButtonItem = homeButton
    }

    @objc private func goToHome() {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            return
        }
        sceneDelegate.showHome()
    }
}
