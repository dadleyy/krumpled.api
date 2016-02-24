bluebird = require "bluebird"

module.exports = do ->

  PortfolioValue = {}

  tof = (v) -> parseFloat v
  
  PortfolioValue.calculate = (portfolio_id) ->
    [resolve, reject] = [null, null]
    trades = null
    symbols = null

    loadedQuotes = (quotes) ->
      value = 0
      net_value = 0

      for t in trades
        sym = (s for s in symbols when s.id = t.symbol)[0]
        quote = (q for q in quotes when q.symbol == sym.symbol)[0]
        continue unless sym and quote
        trade_value = (tof quote.price) * (tof t.shares)
        trade_total_cost = (tof t.price_per_share) * (tof t.shares)
        value += trade_value
        net_value += trade_value - trade_total_cost

      resolve {value: value, net: net_value}

    failedQuotes = ->
      reject new Error 422

    loadedSymbols = (err, loaded_symbols) ->
      return reject new Error err if err
      return reject new Error 404 if not loadedSymbols

      symbols = loaded_symbols
      symbol_list = (s.symbol for s in symbols)

      QuoteService.lookup symbol_list
        .then loadedQuotes
        .catch failedQuotes

    found = (err, portfolio) ->
      return reject new Error err if err
      return reject new Error 404 if not portfolio

      trades = portfolio.trades

      if trades.length == 0
        return resolve 0

      symbols = []
      for t in trades
        symbols.push t.symbol if (symbols.indexOf t.symbol) == -1

      Symbol.find {id: symbols}, loadedSymbols

    find = (fns...) ->
      [resolve, reject] = fns

      Portfolio.findOne {id: portfolio_id}
        .populate "trades", {where: {date_sold: null}}
        .exec found

      true

    new bluebird find

  PortfolioValue
