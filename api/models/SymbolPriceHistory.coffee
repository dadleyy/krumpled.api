ModelFactory = require "../lib/ModelFactory"

module.exports = do ->

  SymbolPriceHistory = ModelFactory {
    "symbol":
      "model": "Symbol"
      "required": true
    "volume":
      "type": "decimal"
    "price":
      "type": "decimal"
    "date":
      "type": "date"
  }, "symbol_price_history"

  SymbolPriceHistory
