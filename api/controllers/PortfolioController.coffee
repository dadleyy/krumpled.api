UserPortfolios = require "../services/UserPortfolios"
bluebird = require "bluebird"

module.exports = do ->

  PortfolioController = {}

  PortfolioController.find = (req, res) ->
    user_id = req.session?.user

    found = (err, user) ->
      return res.serverError err if err
      portfolios = user.portfolios or []
      res.ok portfolios

    User.findOne {id: user_id}
      .populate "portfolios"
      .exec found

  PortfolioController.create = (req, res) ->
    name = req.body?.name
    created_portfolio = null

    if not name
      return res.badRequest {fields: "name_missing"}

    mapped = (err, new_mapping) ->
      return res.modelError err if err
      res.ok created_portfolio


    created = (err, portfolio) ->
      return res.modelError err if err
      created_portfolio = portfolio

      UserPortfolioMapping.create {
        user: req.session.user
        portfolio: portfolio.id
      }, mapped

    Portfolio.create {
      name: name
    }, created

  PortfolioController.update = (req, res) ->
    res.noContent()

  PortfolioController.destroy = (req, res) ->
    user_id = req.session.user
    portfolio_id = req.params.id

    destroyed = () ->
      res.ok {"destroyed": portfolio_id}

    failed = (err) ->
      res.serverError err

    found = (err, portfolio) ->
      return res.serverError err if err
      return res.notFound "1" if not portfolio
      users = portfolio.users or []
      exists = (u for u in users when u.id == user_id).length >= 1
      return res.notFound "2" if not exists

      async = bluebird.all [
        Portfolio.destroy {id: portfolio_id}
        UserPortfolioMapping.destroy {portfolio: portfolio_id}
      ]
      (async.then destroyed).catch failed

    Portfolio.findOne {id: portfolio_id}
      .populate "users"
      .exec found

    


  PortfolioController
