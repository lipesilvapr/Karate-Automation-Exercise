@ui @products
Feature: UI - Produtos

  Background:
    * call read('classpath:pages/common-page.feature@openPath') { path: '/products' }

  @smoke
  Scenario: Página de produtos lista itens
    * match text('.features_items h2.title') == '#regex (?i)all products'
    * def items = locateAll('.features_items .product-image-wrapper')
    * assert items.length > 0

  Scenario Outline: Buscar produto por "<term>"
    * input('#search_product', '<term>')
    * click('#submit_search')
    * waitUntil(".features_items h2.title", "_.textContent.toLowerCase().includes('searched products')")
    * match text('.features_items h2.title') == '#regex (?i)searched products'
    * def results = locateAll('.features_items .product-image-wrapper')
    * assert results.length > 0

    Examples:
      | term  |
      | top   |
      | jean  |
      | dress |
