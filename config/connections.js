var dotenv = require("dotenv");

module.exports.connections = (function() {

  dotenv.load();

  var config = {
    mysqldb: {
      adapter: "sails-mysql",
      host: process.env["DATBASE_HOSTNAME"] || "localhost",
      user: process.env["DATABASE_USERNAME"] || "root",
      password: process.env["DATBASE_PASSWORD"] || "password",
      database: process.env["DATABASE_DATABASE"] || "opex"
    }
  };

  return config;

})();
