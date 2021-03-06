ModelFactory = require "../lib/ModelFactory"

module.exports = do ->

  Symbol = ModelFactory {
    "full_name":
      "type": "string"
      "required": true
    "symbol":
      "type": "string"
      "required": true
    "exchange":
      "model": "Exchange"
    "price_history":
      "collection": "SymbolPriceHistory"
      "via": "symbol"
  }

  Symbol
