@ui @auth
Feature: UI - Login

  Background:
    * call read('classpath:pages/common-page.feature@openHome')
    * call read('classpath:pages/login-page.feature@open')

  @smoke
  Scenario: Login com credenciais válidas
    # massa criada via API (rápido e isolado) e removida ao final
    * def created = call read('classpath:helpers/create-user.feature')
    * def user = created.user
    * configure afterScenario = cleanup

    * call read('classpath:pages/login-page.feature@login') { email: '#(user.email)', password: '#(user.password)' }

    * waitFor("//a[contains(.,'Logged in as')]")
    * match text("//a[contains(.,'Logged in as')]") contains user.name

  Scenario Outline: Login inválido - <caso>
    * call read('classpath:pages/login-page.feature@login') { email: '<email>', password: '<password>' }
    * waitFor("form[action='/login'] p")
    * match text("form[action='/login'] p") == 'Your email or password is incorrect!'

    Examples:
      | caso                | email                  | password    |
      | usuario inexistente | nao.existe@example.com | Qualquer123 |
      | senha qualquer      | outro.fake@example.com | 123456      |
