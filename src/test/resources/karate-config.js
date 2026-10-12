function fn() {
  var env = karate.env || 'qa';
  karate.log('karate.env =', env);

  var environments = {
    qa: {
      baseUrl: 'https://automationexercise.com'
    }
    // adicione outros ambientes aqui (ex.: stg, prod)
  };

  var config = environments[env] || environments.qa;
  config.env = env;
  config.apiUrl = config.baseUrl + '/api';

  // utilitários disponíveis em todas as features
  config.data = Java.type('com.automationexercise.support.DataGenerator');

  // Hook de limpeza: remove o usuário `user` (se existir no cenário) via API.
  // Uso nas features:  * configure afterScenario = cleanup
  config.cleanup = function () {
    var u = karate.get('user');
    if (u && u.email && u.password) {
      karate.call('classpath:helpers/delete-user.feature', { email: u.email, password: u.password });
    }
  };

  // ---- HTTP ----
  karate.configure('connectTimeout', 15000);
  karate.configure('readTimeout', 30000);
  karate.configure('retry', { count: 10, interval: 2000 });

    // ---- UI (Chrome) ----
  // -Dheadless=false  -> abre o navegador visível
  // -Dci=true         -> flags necessárias em containers/CI
  // -Ddriver.log=true -> mostra o log do driver (útil p/ diagnosticar falhas ao abrir o Chrome)
  var headless = karate.properties['headless'] != 'false';
  var ci = karate.properties['ci'] == 'true';
  var driverLog = karate.properties['driver.log'] == 'true';
  var chromeArgs = [
    '--window-size=1920,1080',
    '--disable-notifications',
    '--disable-popup-blocking',
    // flags que reduzem lentidão/falhas na inicialização do Chrome
    '--disable-extensions',
    '--disable-gpu',
    '--no-first-run',
    '--no-default-browser-check',
    '--disable-background-networking'
  ];
  if (ci) {
    chromeArgs.push('--no-sandbox', '--disable-dev-shm-usage');
  }
  karate.configure('driver', {
    type: 'chrome',
    headless: headless,
    showDriverLog: driverLog,
    timeout: 50000,
    addOptions: chromeArgs
  });

  return config;
}
