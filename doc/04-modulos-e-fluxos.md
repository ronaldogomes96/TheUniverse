# Modulos e Fluxos Detalhados

## 1. Onboarding

**Arquivos**:
- `TheUniverse/TheUniverse/Features/Onboarding/OnboardingFlowView.swift`
- `TheUniverse/TheUniverse/Controller/OnBoarding/OnBoardingViewController.swift`

**Fluxo**:
1. `SceneDelegate` chama `showOnboarding()` se `HasSeenOnboarding` for false.
2. `OnBoardingViewController` hospeda `OnboardingFlowView` via `UIHostingController`.
3. Ao finalizar, `finish()` chama `SceneDelegate.showHome()` e marca onboarding como visto.

**Decisao**: SwiftUI para onboarding por simplicidade de layout e animacoes.

## 2. Home (SwiftUI)

**Arquivos**:
- `TheUniverse/TheUniverse/Features/Home/HomeView.swift`
- `TheUniverse/TheUniverse/Features/Home/HomeViewModel.swift`
- `TheUniverse/TheUniverse/Core/DesignSystem/UniverseDesignSystem.swift`

**Fluxo**:
1. `HomeViewController` hospeda `HomeView`.
2. `HomeView` chama `viewModel.load()` em `task`.
3. `HomeViewModel`:
   - Busca APOD via `AstronomyAPIClient`.
   - Usa `DiskCache` para evitar refetch diario.
   - Busca snapshot do ceu via `LocationService` + `SkyObservationService`.
   - Carrega fatos rapidos e historico/favoritos com `UserCollectionsStore`.
4. Acoes da UI chamam closures para navegar (explorer, live sky, detail).

**Observacao**: O design system `UniverseDesignSystem` centraliza tipografia, cores e espacos para consistencia visual.

## 3. Mapa do Ceu (LiveSky)

**Arquivos**:
- `TheUniverse/TheUniverse/Features/LiveSky/LiveSkyView.swift`
- `TheUniverse/TheUniverse/Features/LiveSky/LiveSkyService.swift`
- `TheUniverse/TheUniverse/Core/Location/LocationService.swift`

**Fluxo**:
1. `LiveSkyViewModel.load()` solicita localizacao.
2. Se negada ou falha, utiliza `UserLocation.unknown`.
3. `SkyObservationService.currentSky` calcula os corpos visiveis.
4. `LiveSkyView` lista snapshots e eventos.

**Tradeoff**: Dados sao estimados localmente (nao astronomicos precisos), mas mantem offline.

## 4. Detalhe do Corpo (SwiftUI)

**Arquivos**:
- `TheUniverse/TheUniverse/Features/CelestialDetail/CelestialDetailView.swift`
- `TheUniverse/TheUniverse/Features/CelestialDetail/CelestialDetailViewModel.swift`
- `TheUniverse/TheUniverse/Core/Content/CelestialContentService.swift`

**Fluxo**:
1. `CelestialDetailViewModel.load()`:
   - Registra visita (`UserCollectionsStore`).
   - Busca `CelestialDetail` via `CelestialContentService`.
2. `CelestialContentService` consolida:
   - Conteudo local (`CuratedContentStore`).
   - Midia remota (`AstronomyAPIClient.searchMedia`).
   - Snapshot live (`AstronomyAPIClient.fetchEphemeris`).
   - Audio procedural (`CosmicAudioService`).
3. `CelestialDetailView` exibe:
   - Header com midia, fatos rapidos.
   - Secoes de conteudo.
   - Galeria.
   - Missoes.
   - Comparacao basica entre corpos.
   - Botao para 3D legado.

## 5. Explorer Legado (UIKit)

### 5.1 TabBar

**Arquivos**:
- `TheUniverse/TheUniverse/View/ListOfCelestialBody/Storyboards/TabBar.storyboard`
- `TheUniverse/TheUniverse/Controller/ListOfCelestialBody/TabBarController.swift`
- `TheUniverse/TheUniverse/ViewModel/ListOfCelestialBody/TabBarViewModel.swift`

**Fluxo**:
1. `TabBarViewController` injeta listas nos `CelestialBodyTableViewController`.
2. Cada tab representa uma categoria (planetas, satelites, estrelas).

### 5.2 Lista de corpos (UITableView)

**Arquivos**:
- `TheUniverse/TheUniverse/Controller/ListOfCelestialBody/CelestialBodyTableViewController.swift`
- `TheUniverse/TheUniverse/View/ListOfCelestialBody/Cell/CelestialBodyTableViewCell.swift`

**Fluxo**:
1. Recebe `celestialBodyNames` e `celestialBodyImageNames`.
2. Selecionar um item abre `CelestialBodyDataViewController`.

### 5.3 Detalhe legado

**Arquivos**:
- `TheUniverse/TheUniverse/Controller/CelestialBodyDescription/CelestialBodyDataController.swift`
- `TheUniverse/TheUniverse/ViewModel/CelestialBodyDescription/CelestialBodyDataViewModel.swift`
- `TheUniverse/TheUniverse/ViewModel/CelestialBodyDescription/CelestialBodyInformationsViewModel.swift`
- `TheUniverse/TheUniverse/ViewModel/CelestialBodyDescription/CelestialBodyImagesViewModel.swift`

**Fluxo**:
1. A tela possui 3 secoes:
   - Galeria de imagens (collection view embedded).
   - Botao de 3D.
   - Secoes textuais.
2. Imagens sao carregadas via `ApiModel` com cache em `Repository`.

## 6. Viewer 3D (ARKit + SceneKit)

**Arquivos**:
- `TheUniverse/TheUniverse/View/3DView/3DView.storyboard`
- `TheUniverse/TheUniverse/Controller/3DView/Image3DViewController.swift`
- `TheUniverse/TheUniverse/ViewModel/3DView/Image3DViewModel.swift`

**Fluxo**:
1. Carrega textura 3D de `Assets.scnassets/3DPlanets`.
2. Cria um `SCNSphere` e aplica textura.
3. Inicia rotacao continua.
4. Usa `ARWorldTrackingConfiguration`.

