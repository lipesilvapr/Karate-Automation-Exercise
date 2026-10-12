@ui @auth
Feature: UI - Cadastro de usuário

  Background:
    * call read('classpath:pages/common-page.feature@openHome')
    * call read('classpath:pages/login-page.feature@open')

  @smoke
  Scenario: Cadastro completo com sucesso
    * def template = read('classpath:data/user-template.json')
    * def user = karate.merge(template, { email: data.randomEmail() })
    * configure afterScenario = cleanup

    * call read('classpath:pages/login-page.feature@startSignup') { name: '#(user.name)', email: '#(user.email)' }

    * waitFor("input[data-qa='password']")
    * click('#id_gender1')
    * input("input[data-qa='password']", user.password)
    * select("select[data-qa='days']", '{}' + user.birth_date)
    * select("select[data-qa='months']", '{}' + user.birth_month)
    * select("select[data-qa='years']", '{}' + user.birth_year)
    * input("input[data-qa='first_name']", user.firstname)
    * input("input[data-qa='last_name']", user.lastname)
    * input("input[data-qa='company']", user.company)
    * input("input[data-qa='address']", user.address1)
    * input("input[data-qa='address2']", user.address2)
    * select("select[data-qa='country']", '{}' + user.country)
    * input("input[data-qa='state']", user.state)
    * input("input[data-qa='city']", user.city)
    * input("input[data-qa='zipcode']", user.zipcode)
    * input("input[data-qa='mobile_number']", user.mobile_number)
    * click("button[data-qa='create-account']")

    * waitFor("h2[data-qa='account-created']")
    * match text("h2[data-qa='account-created']") == '#regex (?i)account created!'

    * click("a[data-qa='continue-button']")
    * waitFor("//a[contains(.,'Logged in as')]")
    * match text("//a[contains(.,'Logged in as')]") contains user.name

  Scenario: Cadastro com email já existente
    * def created = call read('classpath:helpers/create-user.feature')
    * def user = created.user
    * configure afterScenario = cleanup

    * call read('classpath:pages/login-page.feature@startSignup') { name: '#(user.name)', email: '#(user.email)' }

    * waitFor("form[action='/signup'] p")
    * match text("form[action='/signup'] p") == 'Email Address already exist!'
