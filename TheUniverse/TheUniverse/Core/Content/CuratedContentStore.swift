import Foundation

final class CuratedContentStore {
    private let celestialBodyModel: CelestialBodyModel
    private let bundle: Bundle

    init(celestialBodyModel: CelestialBodyModel = CelestialBodyModel(), bundle: Bundle = .main) {
        self.celestialBodyModel = celestialBodyModel
        self.bundle = bundle
    }

    func content(for bodyID: CelestialBodyID) -> CuratedContent {
        let info = celestialBodyModel.getCelestialBodyDescriptionFromJson(jsonName: bodyID.jsonResourceName)?.info ?? []
        let sections = info.map { CelestialSection(title: $0.title, body: $0.description) }

        return CuratedContent(
            body: bodyID,
            heroTitle: bodyID.displayName,
            heroSubtitle: bodyID.subtitle,
            sections: sections,
            quickFacts: quickFacts(for: bodyID),
            curiosities: curiosities(for: bodyID),
            relatedMissions: missions(for: bodyID),
            comparisonCandidates: comparisonCandidates(for: bodyID)
        )
    }

    func featuredBodies() -> [CelestialBodyID] {
        [.moon, .jupiter, .saturn, .mars, .venus, .sun, .earth]
    }

    func quickFactFeed() -> [QuickFact] {
        [
            QuickFact(title: "Luz solar", value: "8 min 20 s", detail: "Tempo médio para a luz do Sol alcançar a Terra."),
            QuickFact(title: "Lua", value: "384.400 km", detail: "Distância média entre a Terra e a Lua."),
            QuickFact(title: "Júpiter", value: "95 luas", detail: "Número de luas confirmadas em catálogos recentes."),
            QuickFact(title: "Saturno", value: "Anéis ativos", detail: "Os anéis permanecem um dos sistemas mais fotogênicos do Sistema Solar.")
        ]
    }

    func cosmicEvents(referenceDate: Date = Date()) -> [CosmicEvent] {
        let calendar = Calendar(identifier: .gregorian)
        return [
            CosmicEvent(name: "Lua cheia", detail: "Boa noite para observar mares e contrastes lunares.", date: calendar.date(byAdding: .day, value: 2, to: referenceDate) ?? referenceDate),
            CosmicEvent(name: "Conjunção Lua + Júpiter", detail: "Os dois brilham próximos no começo da noite.", date: calendar.date(byAdding: .day, value: 5, to: referenceDate) ?? referenceDate),
            CosmicEvent(name: "Janela das Perseidas", detail: "Melhor após meia-noite, longe da poluição luminosa.", date: calendar.date(byAdding: .day, value: 12, to: referenceDate) ?? referenceDate)
        ]
    }

    func audioMetadata(for bodyID: CelestialBodyID) -> AudioMetadata {
        switch bodyID {
        case .moon:
            return AudioMetadata(
                kind: .scientificSonification,
                title: "Lua em sonificação",
                description: "Uma tradução sonora de dados lunares ligada à exploração e ao conhecimento acumulado sobre a Lua.",
                attribution: "NASA Goddard / SYSTEM Sounds",
                sourceURL: URL(string: "https://svs.gsfc.nasa.gov/13204/")
            )
        case .sun:
            return AudioMetadata(
                kind: .dataInspiredAmbient,
                title: "Heliosfera inspirada",
                description: "Uma ambientação procedural inspirada em atividade solar, rotação e energia irradiada.",
                attribution: "TheUniverse procedural engine",
                sourceURL: URL(string: "https://science.nasa.gov/sun/")
            )
        default:
            return AudioMetadata(
                kind: .dataInspiredAmbient,
                title: "Paisagem sonora de \(bodyID.displayName)",
                description: "Ambientação inspirada em rotação, composição e escala orbital de \(bodyID.displayName).",
                attribution: "TheUniverse procedural engine",
                sourceURL: nil
            )
        }
    }

    private func quickFacts(for bodyID: CelestialBodyID) -> [CelestialQuickFact] {
        switch bodyID {
        case .earth:
            return [
                CelestialQuickFact(label: "Raio", value: "6.371 km"),
                CelestialQuickFact(label: "Dia", value: "23h56m"),
                CelestialQuickFact(label: "Ano", value: "365,25 dias")
            ]
        case .moon:
            return [
                CelestialQuickFact(label: "Raio", value: "1.737 km"),
                CelestialQuickFact(label: "Fase", value: "Muda ao longo do mês"),
                CelestialQuickFact(label: "Órbita", value: "27,3 dias")
            ]
        case .jupiter:
            return [
                CelestialQuickFact(label: "Raio", value: "69.911 km"),
                CelestialQuickFact(label: "Dia", value: "9h56m"),
                CelestialQuickFact(label: "Ano", value: "11,86 anos")
            ]
        case .saturn:
            return [
                CelestialQuickFact(label: "Raio", value: "58.232 km"),
                CelestialQuickFact(label: "Anéis", value: "Gelo e rocha"),
                CelestialQuickFact(label: "Ano", value: "29,4 anos")
            ]
        case .sun:
            return [
                CelestialQuickFact(label: "Tipo", value: "Anã amarela"),
                CelestialQuickFact(label: "Raio", value: "696.340 km"),
                CelestialQuickFact(label: "Rotação", value: "25 a 35 dias")
            ]
        default:
            return [
                CelestialQuickFact(label: "Categoria", value: bodyID.category.title),
                CelestialQuickFact(label: "Nome", value: bodyID.displayName),
                CelestialQuickFact(label: "Modo", value: "Curadoria offline")
            ]
        }
    }

    private func curiosities(for bodyID: CelestialBodyID) -> [String] {
        switch bodyID {
        case .earth:
            return ["É o único mundo conhecido com oceanos líquidos estáveis na superfície.", "A inclinação do eixo cria as estações do ano."]
        case .moon:
            return ["A Lua estabiliza parte da inclinação da Terra.", "A mesma face lunar é voltada para nós na maior parte do tempo."]
        case .jupiter:
            return ["A Grande Mancha Vermelha é uma tempestade gigantesca e antiga.", "Seu campo magnético é extremamente intenso."]
        default:
            return ["Cada corpo deste catálogo une conteúdo local com camadas dinâmicas quando disponíveis."]
        }
    }

    private func missions(for bodyID: CelestialBodyID) -> [MissionMetadata] {
        switch bodyID {
        case .earth:
            return [MissionMetadata(name: "EPIC", summary: "Observa a Terra a partir do ponto L1 com imagens completas do disco terrestre.")]
        case .moon:
            return [MissionMetadata(name: "LRO", summary: "Mapeia a superfície lunar com alta resolução desde 2009.")]
        case .jupiter:
            return [MissionMetadata(name: "Juno", summary: "Estuda atmosfera, composição e campo magnético de Júpiter.")]
        case .saturn:
            return [MissionMetadata(name: "Cassini-Huygens", summary: "Transformou nosso conhecimento sobre Saturno, Titã e Encélado.")]
        case .sun:
            return [MissionMetadata(name: "Parker Solar Probe", summary: "Investiga o ambiente solar em distâncias sem precedentes.")]
        default:
            return [MissionMetadata(name: "NASA Archive", summary: "Corpo com material curado e expansível por missões futuras.")]
        }
    }

    private func comparisonCandidates(for bodyID: CelestialBodyID) -> [CelestialBodyID] {
        switch bodyID.category {
        case .planets:
            return [.earth, .mars, .jupiter, .saturn].filter { $0 != bodyID }
        case .satellites:
            return [.moon, .titan, .io, .europa].compactMap { $0 }.filter { $0 != bodyID }
        case .stars:
            return [.earth, .jupiter]
        case .events, .missions:
            return [.earth]
        }
    }
}

private extension CelestialBodyID {
    static var europa: CelestialBodyID? { nil }
}
