# Documentacao Tecnica - TheUniverse

Este diretorio contem a documentacao tecnica completa do projeto TheUniverse. Os arquivos estao organizados por assunto para facilitar o estudo. Recomendo ler na ordem abaixo, pois cada documento referencia conceitos do anterior.

## Indice

1. `doc/01-visao-geral.md` - Visao geral do produto, objetivos e experiencia do usuario.
2. `doc/02-arquitetura.md` - Arquitetura de alto nivel, camadas, dependencias e fluxo principal.
3. `doc/03-fontes-de-dados.md` - Fontes de dados locais e remotas, caching, persistencia e formatos.
4. `doc/04-modulos-e-fluxos.md` - Modulos, telas e fluxos detalhados (UIKit + SwiftUI).
5. `doc/05-decisoes-tecnologicas.md` - Linguagens, frameworks, justificativas, tradeoffs e riscos.
6. `doc/06-testing.md` - Estrutura de testes, mocks e estrategia atual.
7. `doc/07-build-e-execucao.md` - Build, configuracoes, chaves e requisitos de permissao.
8. `doc/08-modelos-de-dados.md` - Modelos centrais, enums e contratos.
9. `doc/09-design-system.md` - Tokens visuais e componentes SwiftUI.

## Como usar esta documentacao

- Os caminhos de arquivos sao sempre relativos ao repositorio. Exemplos: `TheUniverse/TheUniverse/Core/Networking/AstronomyAPIClient.swift`.
- Para entender o fluxo de dados end-to-end, leia `doc/02-arquitetura.md` e `doc/04-modulos-e-fluxos.md` em sequencia.
- Para entender o porque das escolhas, leia `doc/05-decisoes-tecnologicas.md`.
