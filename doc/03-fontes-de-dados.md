# Fontes de Dados, Cache e Persistencia

## 1. Conteudo Local (Offline)

### Arquivos principais

- `TheUniverse/TheUniverse/Data/celestialBody.json`
  - Contem listas de nomes e imagens (planetas, satelites, estrelas).
- `TheUniverse/TheUniverse/Data/Planets/*.json`
- `TheUniverse/TheUniverse/Data/Satellites/*.json`
- `TheUniverse/TheUniverse/Data/Star/sun.json`

### Como e usado

- `CelestialBodyModel` carrega `celestialBody.json` para montar listas no modo legado.
- `CuratedContentStore` le os arquivos JSON individuais para gerar secoes de texto curadas.

### Exemplo de fluxo

```
CelestialBodyModel.getCelestialBodyDescriptionFromJson(jsonName:)
  -> Bundle.main.url(forResource: jsonName)
  -> JSONDecoder().decode(CelestialBodyInformations.self)
```

### Beneficios

- Funciona offline.
- Conteudo controlado e editorialmente curado.

### Tradeoffs

- Precisa de manutencao manual.
- Conteudo pode ficar desatualizado sem atualizacao do app.

## 2. NASA APOD (Astronomy Picture of the Day)

### Onde e usado

- `AstronomyAPIClient.fetchDailyAstronomyFeature`
- `HomeViewModel.loadHero`

### URL

- `https://api.nasa.gov/planetary/apod`

### Configuracao

- Chave via `NASA_API_KEY` no `Info.plist`.
- Valor padrao no projeto: `DEMO_KEY`.

### Cache

- `DiskCache` salva `apod.json` por 24 horas.

### Tradeoffs

- Depende de rede e chave valida.
- Pode falhar e cair em mensagem de fallback.

## 3. NASA Images API (Galeria)

### Onde e usado

- **Legado**: `ApiModel.nasaApiCall` e `ApiModel.fetchImage`
- **Novo**: `AstronomyAPIClient.searchMedia`

### URL

- `https://images-api.nasa.gov/search?q={query}&media_type=image`

### Cache

- Legado: `Repository` salva URLs em JSON no `Documents`.
- Imagens: `NSCache` em memoria.

### Tradeoffs

- O endpoint retorna muitos itens, e o app corta manualmente.
- Sem paginacao formal.

## 4. Estimativas Locais de Ceu (Ephemeris)

### Onde e usado

- `AstronomyAPIClient.fetchEphemeris`
- `SkyObservationService`

### Observacao

Nao ha integracao com um backend astronomico real. O calculo de altitude, rise/set e fase e aproximado, baseado em funcoes locais e heuristicas. Isso permite um modo offline, mas nao e astronomicamente preciso.

### Cache

- `DiskCache` guarda snapshot por 1 hora (`maxAge: 3600`).

### Tradeoffs

- **Pro**: funciona offline e e rapido.
- **Contra**: valores sao estimativas, nao dados reais.

## 5. Persistencia de Estado do Usuario

### UserDefaults

- `UserCollectionsStore` guarda:
  - `RecentBodies` (ultimos visitados)
  - `FavoriteBodies` (favoritos)

### Arquivos Locais

- `Repository` (legado) grava JSON com URLs de imagens no `Documents`.

## 6. Assets Locais

- `Shared/Assets.xcassets` contem imagens 2D para cada corpo.
- `Shared/Assets.scnassets` contem texturas 3D para SceneKit.

