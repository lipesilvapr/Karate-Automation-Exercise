@api @user @auth
Feature: API - Verificação de login

  Background:
    * url apiUrl
    * path 'verifyLogin'
    * def created = call read('classpath:helpers/create-user.feature')
    * def user = created.user
    * configure afterScenario = cleanup

  @smoke
  Scenario: Login válido
    Given form field email = user.email
    And form field password = user.password
    When method post
    Then status 200
    * json body = response
    * match body.responseCode == 200
    * match body.message == 'User exists!'

  Scenario: Senha incorreta
    Given form field email = user.email
    And form field password = 'senha-errada'
    When method post
    Then status 200
    * json body = response
    * match body.responseCode == 404
    * match body.message == 'User not found!'

  Scenario: Parâmetro email ausente
    Given form field password = user.password
    When method post
    Then status 200
    * json body = response
    * match body.responseCode == 400
    * match body.message == 'Bad request, email or password parameter is missing in POST request.'

  Scenario: DELETE /verifyLogin não é suportado
    When method delete
    Then status 200
    * json body = response
    * match body.responseCode == 405
    * match body.message == 'This request method is not supported.'
