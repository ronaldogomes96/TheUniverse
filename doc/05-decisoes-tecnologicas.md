# Decisoes Tecnologicas, Justificativas e Tradeoffs

## 1. Swift como linguagem unica

**Razao**
- Ecossistema nativo iOS, acesso a SwiftUI, UIKit e frameworks Apple.
- Facilita integracao com ARKit, CoreLocation e AVFoundation.

**Tradeoffs**
- Dependencia total de ferramentas Apple (Xcode, iOS).
- Menor reutilizacao multiplataforma.

## 2. Arquitetura hibrida (UIKit + SwiftUI)

**Razao**
- Permite evoluir UI moderna sem reescrever telas antigas.
- Migracao gradual reduz risco e tempo.

**Tradeoffs**
- Complexidade extra na navegacao.
- Necessidade de ponte (UIHostingController) e estado duplicado.

## 3. MVVM com Services

**Razao**
- Separacao clara entre UI e logica.
- Facilita testes em ViewModels.
- Services centralizam chamadas de rede e agregacao de conteudo.

**Tradeoffs**
- Em algumas partes legadas, MVVM e incompleto.
- Existe duplicidade de logica entre `ApiModel` (legado) e `AstronomyAPIClient` (novo).

## 4. Sem backend proprio

**Razao**
- Reduz custos e complexidade inicial.
- NASA APIs oferecem conteudo suficiente.
- Conteudo curado local garante offline.

**Tradeoffs**
- Limitado as APIs publicas.
- Dificil personalizar ou expandir dados sem atualizar app.

## 5. Estimativas locais para LiveSky

**Razao**
- Evita dependencia de APIs astronomicas complexas.
- Funciona offline.
- Resposta rapida e consistente.

**Tradeoffs**
- Nao e astronomicamente preciso.
- Pode gerar discrepancias percebidas por usuarios avancados.

## 6. Cache local simples (DiskCache + UserDefaults + Repository)

**Razao**
- Implementacao rapida e sem dependencias.
- Adequado para dados pequenos (APOD, snapshots, favoritos).

**Tradeoffs**
- Sem controle sofisticado de expiracao.
- `Repository` grava JSON manualmente, sem migracao.

## 7. ARKit + SceneKit para 3D

**Razao**
- Integracao nativa iOS.
- Simples para mostrar uma esfera com textura.

**Tradeoffs**
- Limitado a dispositivos com suporte AR.
- Experiencia e basica (sem modelos 3D complexos).

## 8. Uso de dados locais em JSON

**Razao**
- Facil de editar e distribuir.
- Mantem informacao controlada e consistente.

**Tradeoffs**
- Necessita de build/release para atualizar conteudo.
- Risco de inconsistencias entre nomes locais e IDs.

## 9. Ausencia de dependencias externas (SPM/CocoaPods)

**Razao**
- Projeto leve e facil de compilar.
- Menor risco de conflitos de versao.

**Tradeoffs**
- Reimplementacao manual de funcoes comuns (cache, networking mais robusto).

