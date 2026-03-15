import AVFoundation
import Foundation

final class CosmicAudioService {
    private let curatedContentStore: CuratedContentStore
    private let fileManager: FileManager

    init(curatedContentStore: CuratedContentStore = CuratedContentStore(), fileManager: FileManager = .default) {
        self.curatedContentStore = curatedContentStore
        self.fileManager = fileManager
    }

    func audioExperience(for body: CelestialBodyID) async -> AudioExperience {
        let metadata = curatedContentStore.audioMetadata(for: body)
        let audioURL = makeAudioFile(for: body, kind: metadata.kind)
        return AudioExperience(
            kind: metadata.kind,
            title: metadata.title,
            description: metadata.description,
            audioURL: audioURL,
            duration: 12,
            attribution: metadata.attribution,
            sourceURL: metadata.sourceURL
        )
    }

    private func makeAudioFile(for body: CelestialBodyID, kind: AudioExperience.Kind) -> URL {
        let caches = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first ?? fileManager.temporaryDirectory
        let url = caches.appendingPathComponent("audio-\(body.rawValue)-\(kind.rawValue).wav")
        if fileManager.fileExists(atPath: url.path) {
            return url
        }

        let sampleRate = 44_100
        let durationSeconds = 12
        let frameCount = sampleRate * durationSeconds
        let baseFrequency = frequency(for: body, kind: kind)
        var samples = Data(capacity: frameCount * 2)

        for sampleIndex in 0..<frameCount {
            let time = Double(sampleIndex) / Double(sampleRate)
            let carrier = sin(2 * .pi * baseFrequency * time)
            let shimmer = sin(2 * .pi * (baseFrequency / 2.0) * time) * 0.35
            let envelope = min(1.0, time / 1.5) * min(1.0, (Double(durationSeconds) - time) / 1.5)
            let value = Int16(max(-1.0, min(1.0, (carrier + shimmer) * envelope * 0.45)) * Double(Int16.max))
            var littleEndian = value.littleEndian
            samples.append(Data(bytes: &littleEndian, count: MemoryLayout<Int16>.size))
        }

        let wavData = makeWAV(samples: samples, sampleRate: sampleRate)
        try? wavData.write(to: url, options: .atomic)
        return url
    }

    private func frequency(for body: CelestialBodyID, kind: AudioExperience.Kind) -> Double {
        let base: Double
        switch body {
        case .sun: base = 196
        case .moon: base = 261.63
        case .earth: base = 220
        case .jupiter: base = 110
        case .saturn: base = 123.47
        case .io: base = 329.63
        case .titan: base = 174.61
        case .neptune: base = 146.83
        default: base = 207.65
        }
        return kind == .scientificSonification ? base * 1.15 : base
    }

    private func makeWAV(samples: Data, sampleRate: Int) -> Data {
        let byteRate = sampleRate * 2
        let blockAlign: UInt16 = 2
        let bitsPerSample: UInt16 = 16
        let dataSize = UInt32(samples.count)
        let chunkSize = 36 + dataSize
        var data = Data()
        data.append("RIFF".data(using: .ascii)!)
        data.append(contentsOf: chunkSize.littleEndianBytes)
        data.append("WAVEfmt ".data(using: .ascii)!)
        data.append(contentsOf: UInt32(16).littleEndianBytes)
        data.append(contentsOf: UInt16(1).littleEndianBytes)
        data.append(contentsOf: UInt16(1).littleEndianBytes)
        data.append(contentsOf: UInt32(sampleRate).littleEndianBytes)
        data.append(contentsOf: UInt32(byteRate).littleEndianBytes)
        data.append(contentsOf: blockAlign.littleEndianBytes)
        data.append(contentsOf: bitsPerSample.littleEndianBytes)
        data.append("data".data(using: .ascii)!)
        data.append(contentsOf: dataSize.littleEndianBytes)
        data.append(samples)
        return data
    }
}

private extension FixedWidthInteger {
    var littleEndianBytes: [UInt8] {
        withUnsafeBytes(of: littleEndian, Array.init)
    }
}
