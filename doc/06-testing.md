# Testes e Qualidade

## Estrutura Atual

- Pasta: `TheUniverse/TheUniverseTests`
- UI Tests: `TheUniverse/TheUniverseUITests`

## Principais arquivos de teste

- `TheUniverse/TheUniverseTests/RepositoryTests.swift`
- `TheUniverse/TheUniverseTests/CelestialBodyModelTests.swift`
- `TheUniverse/TheUniverseTests/CelestialBodyDataViewModelTests.swift`
- `TheUniverse/TheUniverseTests/CelestialBodyInformationsViewModelTests.swift`
- `TheUniverse/TheUniverseTests/ApiModelTests.swift`
- `TheUniverse/TheUniverseTests/TabBarViewModelTests.swift`

## O que e testado

- Persistencia simples em `Repository`.
- Modelos de dados (decodificacao de JSON local).
- ViewModels legados.
- Comportamento do `ApiModel` com mocks de `URLSession`.

## Mocks e suporte

- Pasta `TheUniverse/TheUniverseTests/Mocks` contem `URLSessionMock`, `DataTaskMock` e `DownloadTaskMock`.
- Essas estruturas permitem simular chamadas de rede sem tocar a internet.

## Lacunas atuais

- Pouca ou nenhuma cobertura para:
  - `AstronomyAPIClient` (novo).
  - `CelestialContentService` e `CuratedContentStore`.
  - ViewModels SwiftUI (`HomeViewModel`, `LiveSkyViewModel`, `CelestialDetailViewModel`).
- UI tests existem, mas parecem focar em fluxos simples legados.

## Sugestoes de melhoria (para estudo)

- Criar testes unitarios para `AstronomyAPIClient` com injeção de `URLSession` e dados mockados.
- Testar `UserCollectionsStore` com `UserDefaults` isolado (`suiteName`).
- Testar `CosmicAudioService` verificando criacao de arquivos e duracao.
- Adicionar testes de snapshot de SwiftUI (usando libs externas, se desejado).

