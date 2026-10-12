@ignore
Feature: Helper - cria usuário via API

  # Uso:
  #   * def created = call read('classpath:helpers/create-user.feature')
  #   * def user = created.user
  # Sobrescrevendo campos:
  #   * def created = call read('classpath:helpers/create-user.feature') { name: 'Outro Nome' }

  Scenario: Criar usuário
    * def template = read('classpath:data/user-template.json')
    * def generated = { email: '#(data.randomEmail())' }
    * def overrides = __arg ? __arg : {}
    * def user = karate.merge(karate.merge(template, generated), overrides)

    Given url apiUrl
    And path 'createAccount'
    And form fields user
    When method post
    Then status 200
    * json body = response
    * match body.responseCode == 201
    * match body.message == 'User created!'
