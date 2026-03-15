# Build, Execucao e Configuracoes

## Requisitos

- macOS com Xcode instalado.
- iOS device ou simulador compatível.
- Se for usar ARKit: dispositivo real com suporte AR.

## Abrindo o projeto

1. Abra `TheUniverse/TheUniverse.xcodeproj` no Xcode.
2. Escolha o target `TheUniverse`.
3. Selecione o simulador ou device e execute.

## Chaves e configuracoes importantes

### NASA_API_KEY

- Localizada em `TheUniverse/TheUniverse/Info.plist`.
- Chave usada por `AstronomyAPIClient` para APOD e EPIC.
- Valor default: `DEMO_KEY`.

### Permissoes

- `NSLocationWhenInUseUsageDescription`
  - Necessaria para o LiveSky usar localizacao.
- `NSCameraUsageDescription`
  - Necessaria para o viewer AR (3D).
- `NSPhotoLibraryAddUsageDescription`
  - Necessaria para salvar imagens no legado.

## Fluxo inicial

- O app inicia em `SceneDelegate` e decide onboarding ou home.
- Chave `HasSeenOnboarding` no `UserDefaults` controla o fluxo.

## Observacao sobre APIs

- APOD e EPIC exigem uma chave valida.
- O projeto usa `DEMO_KEY`, que possui limites de taxa.

