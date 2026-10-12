@ignore
Feature: Página de Login / Signup

  @open
  Scenario: Navegar até a página de login
    * click("a[href='/login']")
    * waitFor("form[action='/login']")

  @login
  Scenario: Preencher credenciais e submeter (args: email, password)
    * input("input[data-qa='login-email']", email)
    * input("input[data-qa='login-password']", password)
    * click("button[data-qa='login-button']")

  @startSignup
  Scenario: Iniciar cadastro (args: name, email)
    * input("input[data-qa='signup-name']", name)
    * input("input[data-qa='signup-email']", email)
    * click("button[data-qa='signup-button']")
