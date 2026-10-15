@api @user
Feature: API - Ciclo de vida do usuário (CRUD)

  Background:
    * url apiUrl
    * configure afterScenario = cleanup

  @smoke
  Scenario: Criar, consultar, atualizar e deletar usuário
    # CREATE
    * def created = call read('classpath:helpers/create-user.feature')
    * def user = created.user

    # READ
    Given path 'getUserDetailByEmail'
    And param email = user.email
    When method get
    Then status 200
    * print 'Response: ', response
    * json body = response
    * match body.responseCode == 200
    * match body.user.email == user.email
    * match body.user.name == user.name

    # UPDATE
    * def updated = karate.merge(user, { company: 'Updated Corp' })
    Given path 'updateAccount'
    And form fields updated
    When method put
    Then status 200
    * print 'Response: ', response
    * json body = response
    * match body.responseCode == 200
    * match body.message == 'User updated!'

    Given path 'getUserDetailByEmail'
    And param email = user.email
    When method get
    Then status 200
    * print 'Response: ', response
    * json body = response
    * match body.user.company == 'Updated Corp'

    # DELETE
    * def payload = { email: '#(user.email)', password: '#(user.password)' }
    Given path 'deleteAccount'
    And form fields payload
    When method delete
    Then status 200
    * print 'Response: ', response
    * json body = response
    * match body.responseCode == 200
    * match body.message == 'Account deleted!'

    # CONFIRMA REMOÇÃO
    Given path 'getUserDetailByEmail'
    And param email = user.email
    When method get
    Then status 200
    * print 'Response: ', response
    * json body = response
    * match body.responseCode == 404

    
  Scenario: Não permite criar usuário com email já cadastrado
    # cria o usuário pela primeira vez (helper)
    * def created = call read('classpath:helpers/create-user.feature')
    * def user = created.user

    # tenta criar de novo com o mesmo email
    Given path 'createAccount'
    And form fields user
    When method post
    Then status 200
    * print 'Response: ', response
    * json body = response
    * match body.responseCode == 400