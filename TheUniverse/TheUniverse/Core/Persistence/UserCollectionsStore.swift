import Foundation

final class UserCollectionsStore {
    private enum Key {
        static let recentBodies = "RecentBodies"
        static let favorites = "FavoriteBodies"
    }

    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func recordVisit(to body: CelestialBodyID) {
        var values = recentBodies().map(\.rawValue)
        values.removeAll(where: { $0 == body.rawValue })
        values.insert(body.rawValue, at: 0)
        defaults.set(Array(values.prefix(8)), forKey: Key.recentBodies)
    }

    func toggleFavorite(_ body: CelestialBodyID) {
        var favorites = favoriteBodies().map(\.rawValue)
        if favorites.contains(body.rawValue) {
            favorites.removeAll(where: { $0 == body.rawValue })
        } else {
            favorites.insert(body.rawValue, at: 0)
        }
        defaults.set(favorites, forKey: Key.favorites)
    }

    func recentBodies() -> [CelestialBodyID] {
        (defaults.stringArray(forKey: Key.recentBodies) ?? []).compactMap(CelestialBodyID.init(rawValue:))
    }

    func favoriteBodies() -> [CelestialBodyID] {
        (defaults.stringArray(forKey: Key.favorites) ?? []).compactMap(CelestialBodyID.init(rawValue:))
    }

    func isFavorite(_ body: CelestialBodyID) -> Bool {
        favoriteBodies().contains(body)
    }
}
