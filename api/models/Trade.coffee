ModelFactory = require "../lib/ModelFactory"

module.exports = do ->

  Trade = ModelFactory {
    "cost":
      "type": "decimal"
      "required": true
    "shares":
      "type": "decimal"
      "required": true
    "symbol":
      "type": "integer"
      "required": true
    "portfolio":
      "model": "portfolio"
      "required": true
    "fee":
      "type": "decimal"
  }

  Trade
