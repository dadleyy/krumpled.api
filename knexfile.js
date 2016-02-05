var dotenv = require('dotenv');

module.exports = (function() {

  var config = {};

  dotenv.load();

  config.production = config.development = {
    client: 'mysql',
    connection: {
      host: process.env["DATBASE_HOSTNAME"] || "localhost",
      user: process.env["DATABASE_USERNAME"] || "root",
      password: process.env["DATBASE_PASSWORD"] || "password",
      database: process.env["DATABASE_DATBASE"] || "opex"
    },
    migrations: {
      tableName: 'migrations'
    }
  };

  return config;

})();
