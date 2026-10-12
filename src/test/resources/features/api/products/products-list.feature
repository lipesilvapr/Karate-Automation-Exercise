@api @products
Feature: API - Lista de produtos

  Background:
    * url apiUrl

  @smoke
  Scenario: GET /productsList retorna todos os produtos
    Given path 'productsList'
    When method get
    Then status 200
    * print 'Response: ', response
    * json body = response
    * match body.responseCode == 200
    * match body.products == '#[_ > 0]'
    * match each body.products ==
      """
      {
        id: '#number',
        name: '#string',
        price: '#string',
        brand: '#string',
        category: { usertype: { usertype: '#string' }, category: '#string' }
      }
      """

  Scenario: POST /productsList não é suportado
    Given path 'productsList'
    When method post
    Then status 200
    * print 'Response: ', response
    * json body = response
    * match body.responseCode == 405
    * match body.message == 'This request method is not supported.'
