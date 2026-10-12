@api @products
Feature: API - Busca de produtos

  Background:
    * url apiUrl
    * path 'searchProduct'

  Scenario Outline: POST /searchProduct retorna resultados para "<term>"
    Given form field search_product = '<term>'
    When method post
    Then status 200
    * json body = response
    * match body.responseCode == 200
    * match body.products == '#[_ > 0]'

    Examples:
      | term   |
      | top    |
      | tshirt |
      | jean   |

  Scenario: POST /searchProduct sem o parâmetro obrigatório
    When method post
    Then status 200
    * json body = response
    * match body.responseCode == 400
    * match body.message == 'Bad request, search_product parameter is missing in POST request.'
