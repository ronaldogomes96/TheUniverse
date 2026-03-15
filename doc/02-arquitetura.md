# Arquitetura do TheUniverse

## Visao Geral de Camadas

O projeto segue uma organizacao por camadas e features, com convivencia de codigo legado (UIKit) e codigo moderno (SwiftUI + async/await). As camadas principais sao:

1. **Shared / App Lifecycle**
   - `TheUniverse/TheUniverse/Shared/AppDelegate.swift`
   - `TheUniverse/TheUniverse/Shared/SceneDelegate.swift`
   - Responsavel por inicializacao e troca de root controllers (Onboarding -> Home -> TabBar legado).

2. **Core (Servicos de Dominio e Infraestrutura)**
   - `Core/Networking/AstronomyAPIClient.swift`
   - `Core/Content/CelestialContentService.swift`
   - `Core/Content/CuratedContentStore.swift`
   - `Core/Persistence/DiskCache.swift`
   - `Core/Persistence/UserCollectionsStore.swift`
   - `Core/Location/LocationService.swift`
   - Fornece acesso a dados remotos, cache local, persistencia e abstrai logica de conteudo.

3. **Features (SwiftUI)**
   - `Features/Home` (HomeView, HomeViewModel)
   - `Features/LiveSky` (LiveSkyView, LiveSkyViewModel)
   - `Features/CelestialDetail` (CelestialDetailView, CelestialDetailViewModel)
   - `Features/AudioExperience` (CosmicAudioService)
   - UI moderna, baseada em dados assincronos (async/await) e observacao com `@ObservedObject`.

4. **Legacy (UIKit + Storyboards)**
   - `Controller`, `View`, `ViewModel`, `Model`.
   - TabBar + TableViewControllers + Storyboards.
   - Dependencias antigas com callbacks, `URLSession.dataTask` e `DispatchGroup`.

5. **Assets e Dados Locais**
   - `TheUniverse/TheUniverse/Data` para JSONs de planetas e satelites.
   - `TheUniverse/TheUniverse/Shared/Assets.xcassets` para imagens 2D.
   - `TheUniverse/TheUniverse/Shared/Assets.scnassets` para texturas 3D.

## Estrutura de Pastas (resumo)

- `TheUniverse/TheUniverse/Core`: infraestrutura e dominio.
- `TheUniverse/TheUniverse/Features`: novas telas e view models SwiftUI.
- `TheUniverse/TheUniverse/Controller`: controladores UIKit.
- `TheUniverse/TheUniverse/View`: views UIKit e storyboards.
- `TheUniverse/TheUniverse/ViewModel`: view models UIKit legados.
- `TheUniverse/TheUniverse/Model`: modelos de dados e camada de API antiga.
- `TheUniverse/TheUniverse/Data`: JSONs locais (conteudo curado).

## Fluxo de Inicializacao

1. **SceneDelegate** decide o root:
   - Chave `HasSeenOnboarding` no `UserDefaults`.
   - Se `true`: entra no `HomeViewController` (SwiftUI via UIHostingController).
   - Se `false`: entra no `OnBoardingViewController`.

2. **HomeViewController** hospeda `HomeView` (SwiftUI) e controla navegacao para:
   - Explorer legado (TabBar.storyboard).
   - LiveSky (SwiftUI).
   - Detail (SwiftUI).

## Fluxo de Dados - Alto Nivel

```
HomeViewModel
  -> AstronomyAPIClient (APOD NASA)
  -> LocationService -> SkyObservationService (estimativas de ceu)
  -> DiskCache (cache local)
  -> UserCollectionsStore (historico/favoritos)

CelestialDetailViewModel
  -> CelestialContentService
      -> CuratedContentStore (conteudo local)
      -> AstronomyAPIClient (media remota + efemerides estimadas)
      -> CosmicAudioService (audio procedural)

LiveSkyViewModel
  -> LocationService
  -> SkyObservationService
      -> AstronomyAPIClient (estimativas + cache)
      -> CuratedContentStore (eventos)
```

## Convivencia SwiftUI + UIKit

O app adota uma estrategia de migracao gradual:

- Novas experiencias ricas (Home, LiveSky, Detail) sao em SwiftUI.
- Explorador legado (listas e detalhes) permanece em UIKit.
- A ponte entre eles ocorre em `HomeViewController`, que apresenta telas SwiftUI ou storyboards conforme necessario.

## Padroes Utilizados

- **MVVM (parcial)**: ViewModels em SwiftUI com `@MainActor`, e ViewModels legados em UIKit.
- **Service Layer**: `AstronomyAPIClient`, `SkyObservationService`, `CelestialContentService`.
- **Repository** (legado): classe `Repository` para persistir JSON local de URLs de imagens.
- **Cache local**: `DiskCache` e `NSCache` para imagens.

## Dependencias do Sistema

- `UIKit`, `SwiftUI`, `Foundation`, `CoreLocation`, `ARKit`, `SceneKit`, `AVFoundation`.
- Nenhum gerenciador de dependencias externo (CocoaPods/SPM) esta sendo usado no projeto.

