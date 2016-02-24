bluebird = require "bluebird"

module.exports = do ->

  UserPortfoliosService = {}

  UserPortfoliosService.validate = (user, portfolio_id, callback) ->
    [resolve, reject] = [null, null]

    fail = (err) ->
      reject err
      callback? err

    found = (err, portfolio) ->
      return fail new Error 401 if err
      return fail new Error 440 unless portfolio
      exists = (u for u in portfolio.users when u.id == user).length > 0
      return fail new Error 403 unless exists
      portfolio = portfolio.toObject()
      delete portfolio.users
      resolve portfolio
      callback? false, portfolio

    resolution = (fns...) ->
      [resolve, reject] = fns

      Portfolio.findOne {id: portfolio_id}
        .populate "users"
        .exec found

    new bluebird resolution

  UserPortfoliosService
