ModelFactory = require "../lib/ModelFactory"

module.exports = do ->

  User = ModelFactory {
    "full_name":
      "type": "string"
      "required": true
    "password":
      "type": "string"
      "required": true
      "hidden": true
    "username":
      "type": "string"
      "required": true
      "unique": true
    "email":
      "type": "email"
      "required": true
      "unique": true
    "portfolios":
      "collection": "portfolio"
      "via": "user"
      "through": "userportfoliomapping"
  }

  User
