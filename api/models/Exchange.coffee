ModelFactory = require "../lib/ModelFactory"

module.exports = do ->

  Exchange = ModelFactory {
    "name":
      "type": "string"
      "required": true
  }

  Exchange
