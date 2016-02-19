ModelFactory = require "../lib/ModelFactory"

module.exports = do ->

  Portfolio = ModelFactory {
    "name":
      "type": "string"
      "required": true
    "users":
      "collection": "user"
      "via": "portfolio"
      "through": "userportfoliomapping"
    "trades":
      "collection": "trade"
      "via": "portfolio"
  }

  Portfolio
