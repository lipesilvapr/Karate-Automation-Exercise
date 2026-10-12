@ignore
Feature: Helper - remove usuário via API

  Scenario: Deletar usuário
    * def payload = { email: '#(email)', password: '#(password)' }

    Given url apiUrl
    And path 'deleteAccount'
    And form fields payload
    When method delete
    Then status 200
