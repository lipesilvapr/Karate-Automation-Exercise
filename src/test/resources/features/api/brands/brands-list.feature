@api @brands
Feature: API - Lista de marcas

  Background:
    * url apiUrl
    * path 'brandsList'

  @smoke
  Scenario: GET /brandsList retorna todas as marcas
    When method get
    Then status 200
    * print 'Response: ', response
    * json body = response
    * match body.responseCode == 200
    * match body.brands == '#[_ > 0]'
    * match each body.brands == { id: '#number', brand: '#string' }

  Scenario: PUT /brandsList não é suportado
    When method put
    Then status 200
    * print 'Response: ', response
    * json body = response
    * match body.responseCode == 405
    * match body.message == 'This request method is not supported.'
