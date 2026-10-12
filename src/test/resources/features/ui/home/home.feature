@ui @home
Feature: UI - Home page

  @smoke
  Scenario: Home carrega com título e produtos em destaque
    * call read('classpath:pages/common-page.feature@openHome')
    * match driver.title == 'Automation Exercise'
    * match text("a[href='/login']") contains 'Signup / Login'
    * def items = locateAll('.features_items .product-image-wrapper')
    * assert items.length > 0
