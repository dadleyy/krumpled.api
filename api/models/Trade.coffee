ModelFactory = require "../lib/ModelFactory"

module.exports = do ->

  Trade = ModelFactory {
    "price_per_share":
      "type": "decimal"
      "required": true
    "shares":
      "type": "decimal"
      "required": true
    "symbol":
      "model": "Symbol"
      "required": true
    "portfolio":
      "model": "Portfolio"
      "required": true
    "fee":
      "type": "decimal"
    "date_sold":
      "type": "date"
  }

  Trade
