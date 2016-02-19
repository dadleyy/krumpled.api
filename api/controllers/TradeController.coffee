module.exports = do ->

  TradeController = {}

  unpack = (obj) ->
    handler = (keys) ->
      (obj[k] for k in keys)

    handler

  TradeController.find = (req, res) ->
    user = req.session.user

    foundTrades = (err, trades) ->
      return res.serverError err if err
      res.ok trades

    foundUser = (err, user) ->
      return res.serverError err if err
      portfolios = (p.id for p in (user.portfolios or []))
      Trade.find {portfolio: portfolios}, foundTrades

    ((User.findOne {id: user}).populate "portfolios").exec foundUser

  TradeController.create = (req, res) ->
    [cost, fee, symbol, shares, portfolio] = (unpack req.body) ["cost", "fee", "symbol", "shares", "portfolio"]
    user = req.session.user

    if not portfolio
      return res.badRequest {fields: "portfolio_missing"}

    created = (err, new_trade) ->
      return res.modelError err if err
      res.ok new_trade

    foundPortfolio = (err, portfolio) ->
      return res.serverError() if err
      return res.notFound 1 if not portfolio
      exists = (u for u in portfolio.users or [] when u.id == user).length >= 1
      return res.notFound 2 if not exists

      Trade.create {
        cost: cost
        shares: shares
        symbol: symbol
        portfolio: portfolio.id
        fee: fee
      }, created

    ((Portfolio.findOne {id: portfolio}).populate "users").exec foundPortfolio

  TradeController.update = (req, res) ->
    res.noContent()

  TradeController.destroy = (req, res) ->
    trade_id = req.params.id
    user = req.session.user

    destroyed = (err) ->
      return res.serverError() if err
      res.ok {destroyed: trade_id}

    foundPortfolio = (err, portfolio) ->
      return res.serverError() if err
      return res.notFound 1 if not portfolio
      users = portfolio.users
      exists = (u for u in users when u.id == user).length >= 1
      return res.notFound 2 if not exists
      Trade.destroy {id: trade_id}, destroyed

    found = (err, trade) ->
      return res.serverError() if err
      return res.notFound 1 if not trade or not trade.portfolio
      ((Portfolio.findOne {id: trade.portfolio.id}).populate "users").exec foundPortfolio

    ((Trade.findOne {id: trade_id}).populate "portfolio").exec found


  TradeController

