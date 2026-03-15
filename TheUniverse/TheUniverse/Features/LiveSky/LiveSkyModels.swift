import Foundation

struct LiveSkyBody: Identifiable {
    var id = UUID()
    let bodyID: CelestialBodyID
    let name: String
    let status: String
    let detail: String
    let visibility: String
}

struct CosmicEvent: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let detail: String
    let date: Date

    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM"
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: date)
    }
}
