# Design System e UI Components

**Arquivo base**: `TheUniverse/TheUniverse/Core/DesignSystem/UniverseDesignSystem.swift`

O design system concentra tokens visuais e componentes reutilizaveis para SwiftUI. Ele cria uma linguagem visual consistente para as telas novas.

## Tokens

### Espacamento

- `UniverseSpacing.xs/sm/md/lg/xl`
- Facilita manter ritmo vertical consistente.

### Tipografia

- `UniverseTypography.heroTitle`
- `UniverseTypography.sectionTitle`
- `UniverseTypography.subtitle`
- `UniverseTypography.body`
- `UniverseTypography.caption`

### Cores

- `UniverseColor.space` fundo principal.
- `UniverseColor.card` base para cards.
- `UniverseColor.glass` overlay translucido.
- `UniverseColor.accentCyan`, `accentGold`, `accentAqua` para destaques.

### Motion

- `UniverseMotion.standard` transicoes curtas.
- `UniverseMotion.slowFloat` animacao lenta para efeitos sutis.

## Componentes

### GlassInfoCard

- Card padrao com preenchimento translucido e stroke suave.
- Usado em Home, LiveSky e Detail.

### SectionHeader

- Titulo + subtitulo com tipografia consistente.

### QuickFactChip

- Exibe fatos rapidos em grid.

### VisibilityBadge

- Tag com estado "Visivel agora" ou "Abaixo do horizonte".

### ParallaxHeader

- Header grande com imagem remota e gradiente.

### SkeletonCard

- Placeholder visual enquanto dados carregam.

## Observacao

As telas UIKit legadas usam um estilo diferente (baseado em UIImageView de fundo e cores definidas em `TheUniverse/TheUniverse/Utils/Colors.swift`). O design system so se aplica as telas SwiftUI.

