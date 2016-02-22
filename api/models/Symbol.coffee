ModelFactory = require "../lib/ModelFactory"

module.exports = do ->

  Symbol = ModelFactory {
    "full_name":
      "type": "string"
      "required": true
    "sybol":
      "type": "string"
      "required": true
  }

  Symbol
