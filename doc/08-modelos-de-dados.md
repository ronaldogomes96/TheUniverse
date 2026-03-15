# Modelos de Dados e Contratos

Este documento detalha os principais modelos (structs/enums) usados no app, com exemplos de uso.

## 1. Identificadores de corpos celestes

**Arquivo**: `TheUniverse/TheUniverse/Core/Content/CelestialBodyID.swift`

### `CelestialBodyID`

- Enum central usado em todo o app moderno.
- Contem nomes, categoria, assets locais e metadados.

Campos derivados importantes:

- `displayName`: nome em portugues.
- `legacyDisplayName`: compatibilidade com nomes antigos (ex: Netuno -> Neturno).
- `jsonResourceName`: nome do arquivo JSON local.
- `modelTextureName`: textura 3D se existir.

**Exemplo de uso**:

```swift
if let bodyID = CelestialBodyID.from(displayName: "Marte") {
    print(bodyID.rawValue) // "mars"
}
```

### `CelestialCategory`

- Enum das categorias (planets, satellites, stars, events, missions).
- Usado para montar grid e filtros no Home.

## 2. Conteudo Curado

**Arquivo**: `TheUniverse/TheUniverse/Core/Content/CelestialContentModels.swift`

### `CuratedContent`

- Representa o conteudo local de um corpo.
- Fonte: `CuratedContentStore`.

Campos:

- `sections`: lista de textos longos.
- `quickFacts`: fatos curtos.
- `curiosities`: curiosidades.
- `relatedMissions`: missoes.

### `CelestialDetail`

- Objeto consolidado exibido em `CelestialDetailView`.
- Combina conteudo local + remoto + audio + snapshot ao vivo.

Campos:

- `heroMedia`: imagem principal.
- `liveSnapshot`: dados de visibilidade (estimados).
- `gallery`: lista de `RemoteMediaAsset`.

## 3. Modelos de Observacao do Ceu

### `BodySnapshot`

- Estado observacional de um corpo em um horario.
- Calculado localmente em `AstronomyAPIClient.estimatedSnapshot`.

Campos:

- `altitude`, `azimuth`: valores estimados.
- `isVisible`: indica se esta acima do horizonte.
- `riseTime`, `setTime`: janela aproximada.

### `SkySnapshot`

- Conjunto de `BodySnapshot` para um local e data.

## 4. Modelos de Audio

### `AudioExperience`

- Representa audio gerado proceduralmente.
- Inclui metadados e URL do arquivo no cache.

**Exemplo de fluxo**:

```
CelestialDetailViewModel
  -> CelestialContentService.detail
      -> CosmicAudioService.audioExperience
          -> makeAudioFile (gera WAV em cache)
```

## 5. Modelos Legados

**Arquivo**: `TheUniverse/TheUniverse/Model/Entities/*`

- `CelestialBody`: listas basicas de nomes e imagens.
- `CelestialBodyInformations`: descreve secoes textuais de um corpo.
- `ApiResponse`: modelo da API de imagens NASA (legado).

Esses modelos suportam as telas UIKit e o pipeline antigo.

