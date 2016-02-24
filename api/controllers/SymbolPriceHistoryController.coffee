module.exports = do ->

  SymbolPriceHistoryController = {}

  upper = (s) -> s?.toUpperCase?()

  SymbolPriceHistoryController.find = (req, res) ->
    symbol = req.query.s or req.query.symbol
    query = {}

    unless symbol
      return res.badRequest "missing symbol"

    if typeof symbol == "string"
      query.symbol = upper symbol
    else
      query.id = +symbol

    found = (found_symbol) ->
      return res.notFound 1 unless found_symbol
      res.ok found_symbol.price_history

    fail = (err) ->
      res.badRequest err

    Symbol.findOne query
      .populate "price_history"
      .then found
      .catch fail

  SymbolPriceHistoryController
