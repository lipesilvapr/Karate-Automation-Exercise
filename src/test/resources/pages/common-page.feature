@ignore
Feature: Ações comuns de página

  @openHome
  Scenario: Abrir a home
    * driver baseUrl
    * waitUntil("document.readyState == 'complete'")
    * call read('@dismissOverlays')

  @openPath
  Scenario: Abrir um caminho relativo (arg: path, ex.: /products)
    * driver baseUrl + path
    * waitUntil("document.readyState == 'complete'")
    * call read('@dismissOverlays')

  @dismissOverlays
  Scenario: Fechar consentimento de cookies e remover anúncios que interceptam cliques
    * optional('.fc-cta-consent').click()
    * script("document.querySelectorAll('ins.adsbygoogle, iframe[id^=aswift_], iframe[id^=google_ads]').forEach(function(e){ e.remove() })")
