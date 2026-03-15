import Foundation

final class DiskCache {
    private let fileManager: FileManager
    private let cacheDirectory: URL

    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
        self.cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
    }

    func write<T: Codable>(_ value: T, to filename: String) throws {
        let url = cacheDirectory.appendingPathComponent(filename)
        let data = try JSONEncoder().encode(CacheEnvelope(value: value))
        try data.write(to: url, options: Data.WritingOptions.atomic)
    }

    func read<T: Codable>(_ type: T.Type, from filename: String, maxAge: TimeInterval) throws -> T? {
        let url = cacheDirectory.appendingPathComponent(filename)
        guard fileManager.fileExists(atPath: url.path) else { return nil }
        let data = try Data(contentsOf: url)
        let envelope = try JSONDecoder().decode(CacheEnvelope<T>.self, from: data)
        let age = Date().timeIntervalSince(envelope.timestamp)
        if age > maxAge {
            return nil
        }
        return envelope.value
    }
}

private struct CacheEnvelope<T: Codable>: Codable {
    let timestamp: Date
    let value: T

    init(value: T, timestamp: Date = Date()) {
        self.timestamp = timestamp
        self.value = value
    }
}
