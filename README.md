# karate-automation-exercise

Scaffold de testes automatizados com [Karate](https://github.com/karatelabs/karate) para
[automationexercise.com](https://automationexercise.com) — **API** e **UI** no mesmo projeto.

## Por que Maven (e não o standalone JAR)?

- Gerencia dependências e versão do Karate de forma reproduzível (`pom.xml`).
- Permite runners JUnit 5 com execução paralela, filtro por tags e relatórios por suíte.
- Integra com IDE, debug e CI sem configuração extra.
- Dá para misturar Java (ex.: `DataGenerator`) quando o JS/Gherkin não basta.

O standalone JAR é ótimo para POCs rápidas, mas escala mal em projeto de longo prazo.

## Pré-requisitos

- JDK 17+
- Maven 3.9+
- Google Chrome instalado (para os testes de UI)

## Estrutura

```
├── pom.xml
├── .github/workflows/tests.yml        # CI (API e UI em jobs separados)
└── src/test
    ├── java/com/automationexercise
    │   ├── runners/                   # ApiTest, UiTest e RunnerSupport
    │   └── support/DataGenerator.java # massa dinâmica (emails únicos etc.)
    └── resources
        ├── karate-config.js           # ambientes, timeouts, driver e hook `cleanup`
        ├── logback-test.xml
        ├── data/                      # massa estática (user-template.json)
        ├── helpers/                   # features reutilizáveis (@ignore): criar/deletar usuário via API
        ├── pages/                     # "page objects" em Gherkin (@ignore)
        └── features/
            ├── api/{products,brands,user}
            └── ui/{home,auth,products}
```

## Executando

```bash
mvn test                                  # tudo (API + UI)
mvn test -Dtest=ApiTest                   # só API
mvn test -Dtest=UiTest                    # só UI
mvn test -Dkarate.tags=@smoke             # filtra por tag (vírgula = OU)
mvn test -Dtest=UiTest -Dheadless=false   # abre o Chrome visível
mvn test -Dtest=UiTest -Dci=true          # flags p/ containers/CI (--no-sandbox)
mvn test -Dapi.threads=8 -Dui.threads=1   # paralelismo
mvn test -Dkarate.env=qa                  # ambiente (ver karate-config.js)
```

Relatórios HTML: `target/karate-reports/api/karate-summary.html` e `target/karate-reports/ui/karate-summary.html`.

## Convenções

- **Tags**: `@api`, `@ui`, `@smoke`, mais uma por domínio (`@products`, `@user`, `@auth`...). `@ignore` = não executa direto (helpers/pages).
- **Massa de dados**: nunca reutilize usuários fixos. Crie via API com `helpers/create-user.feature` e limpe com `* configure afterScenario = cleanup`.
- **Pages**: seletores ficam só em `pages/`. As features de UI descrevem comportamento, não detalhes do DOM.
- **Respostas da API**: o site devolve HTTP 200 com `Content-Type: text/html`, e o status real vem em `responseCode` no corpo. Por isso as features fazem `* json body = response` e validam `body.responseCode`.

## Observações sobre o site

- O site exibe banner de consentimento e anúncios que podem interceptar cliques. `common-page.feature@dismissOverlays` trata os casos comuns; ajuste se aparecerem novos.
- Por ser um site público compartilhado, evite paralelismo alto na UI.
