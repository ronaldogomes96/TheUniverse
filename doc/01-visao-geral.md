# Visao Geral do Projeto

## Objetivo do Produto
TheUniverse e um aplicativo iOS de astronomia. O objetivo principal e permitir que o usuario explore planetas, satelites naturais e estrelas com uma combinacao de:

- Conteudo curado offline (JSONs locais com descricoes e curiosidades).
- Midia remota (imagens NASA via API de imagens).
- Camada dinamica "ao vivo" baseada em localizacao, com estimativas de visibilidade.
- Experiencia visual moderna (SwiftUI) e um legado UIKit (listas e detalhes) mantendo compatibilidade.
- Experiencia 3D/AR para visualizacao de corpos celestes.

## Principais Experiencias

1. **Home (SwiftUI)**
   - Destaque do dia (APOD da NASA), panorama do ceu e cards de exploracao.
   - Entrada para as categorias (planetas, satelites, estrelas) e para o mapa do ceu.

2. **Mapa do Ceu (Live Sky)**
   - Lista de corpos com estimativa de visibilidade, altitude e janelas de observacao.
   - Usa localizacao quando disponivel, e um fallback offline quando nao.

3. **Detalhe do Corpo Celeste (SwiftUI)**
   - Header com midia, fatos rapidos, secoes curadas, galeria, missoes relacionadas.
   - Botao para abrir a experiencia 3D legada.
   - Mini player de audio gerado proceduralmente.

4. **Explorador Legado (UIKit + Storyboard)**
   - TabBar com planetas, satelites e estrelas.
   - Lista de corpos com imagem local.
   - Tela de detalhes com secoes, imagens da NASA e botao para 3D.

5. **Onboarding (SwiftUI)**
   - Explica os pilares da experiencia antes de entrar no app.

## Linguagens e Plataformas

- **Swift** como linguagem principal.
- **iOS** como plataforma, com foco em UIKit e SwiftUI.
- **ARKit/SceneKit** para visualizacao 3D.
- **CoreLocation** para contexto observacional.

## Filosofia de Conteudo

O projeto combina conteudo local e remoto para garantir uma experiencia consistente mesmo offline. Em pratica:

- O conteudo curado local (JSONs) garante uma base de informacoes e descricao.
- A midia remota (NASA Images) enriquece visualmente.
- O "live sky" usa estimativas locais para evitar dependencia de um backend complexo.

## Exemplo de Jornada do Usuario

1. Usuario abre o app.
2. Se ainda nao viu o onboarding, passa por 3 telas explicativas (SwiftUI).
3. Entra no Home, ve o destaque APOD e um resumo do ceu local.
4. Clica em "Ver mapa do ceu" e abre LiveSkyView.
5. Seleciona um corpo e abre CelestialDetailView.
6. Decide abrir o viewer 3D (ARKit/SceneKit) como experiencia legada.

