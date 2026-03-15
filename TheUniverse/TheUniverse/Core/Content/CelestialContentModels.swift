import Foundation

struct DailyAstronomyFeature: Codable, Equatable {
    let title: String
    let subtitle: String
    let date: String
    let mediaURL: URL
    let thumbnailURL: URL?
    let explanation: String
    let copyright: String?
    let source: URL?
}

struct EarthImageAsset: Codable, Equatable {
    let imageURL: URL
    let caption: String
    let date: String
}

struct RemoteMediaAsset: Codable, Equatable, Identifiable {
    let id: UUID
    let title: String
    let imageURL: URL
    let thumbnailURL: URL?
    let sourceURL: URL?

    init(id: UUID = UUID(), title: String, imageURL: URL, thumbnailURL: URL? = nil, sourceURL: URL? = nil) {
        self.id = id
        self.title = title
        self.imageURL = imageURL
        self.thumbnailURL = thumbnailURL
        self.sourceURL = sourceURL
    }
}

struct UserLocation: Codable, Equatable {
    let latitude: Double
    let longitude: Double
    let displayName: String

    static let unknown = UserLocation(latitude: 0, longitude: 0, displayName: "Localização aproximada")
}

struct BodySnapshot: Codable, Equatable, Identifiable {
    var id = UUID()
    let bodyID: CelestialBodyID
    let timestamp: Date
    let distanceFromEarth: String?
    let distanceFromSun: String?
    let altitude: Double?
    let azimuth: Double?
    let isVisible: Bool
    let riseTime: Date?
    let setTime: Date?
    let illuminationFraction: Double?
    let phaseDescription: String?
    let source: String
    let isStale: Bool
}

struct SkySnapshot: Codable, Equatable {
    let timestamp: Date
    let observerLocation: UserLocation
    let visibleBodies: [BodySnapshot]
    let featuredBody: BodySnapshot?
    let tonightHighlights: [CosmicEvent]
}

struct ObservationWindow: Codable, Equatable {
    enum Quality: String, Codable {
        case great
        case good
        case fair
        case poor
    }

    let start: Date
    let end: Date
    let quality: Quality
    let reason: String
}

struct AudioExperience: Codable, Equatable, Identifiable {
    enum Kind: String, Codable {
        case scientificSonification
        case dataInspiredAmbient
    }

    var id = UUID()
    let kind: Kind
    let title: String
    let description: String
    let audioURL: URL
    let duration: TimeInterval
    let attribution: String
    let sourceURL: URL?
}

struct CelestialQuickFact: Codable, Equatable, Identifiable {
    var id = UUID()
    let label: String
    let value: String
}

struct CelestialSection: Codable, Equatable, Identifiable {
    var id = UUID()
    let title: String
    let body: String
}

struct MissionMetadata: Codable, Equatable, Identifiable {
    var id = UUID()
    let name: String
    let summary: String
}

struct BodyComparison: Codable, Equatable {
    let lhs: CelestialBodyID
    let rhs: CelestialBodyID
    let metrics: [CelestialQuickFact]
}

struct CelestialDetail: Codable, Equatable {
    let body: CelestialBodyID
    let heroMedia: RemoteMediaAsset?
    let quickFacts: [CelestialQuickFact]
    let liveSnapshot: BodySnapshot?
    let audioExperience: AudioExperience?
    let sections: [CelestialSection]
    let gallery: [RemoteMediaAsset]
    let relatedMissions: [MissionMetadata]
    let comparisonCandidates: [CelestialBodyID]
}

struct AudioMetadata: Codable, Equatable {
    let kind: AudioExperience.Kind
    let title: String
    let description: String
    let attribution: String
    let sourceURL: URL?
}

struct CuratedContent: Codable, Equatable {
    let body: CelestialBodyID
    let heroTitle: String
    let heroSubtitle: String
    let sections: [CelestialSection]
    let quickFacts: [CelestialQuickFact]
    let curiosities: [String]
    let relatedMissions: [MissionMetadata]
    let comparisonCandidates: [CelestialBodyID]
}
