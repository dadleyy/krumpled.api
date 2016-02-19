ModelFactory = require "../lib/ModelFactory"

module.exports = do ->

  UserPortfolioMapping = ModelFactory {
    "user":
      "model": "user"
    "portfolio":
      "model": "portfolio"
  }, "user_to_portfolio"

  UserPortfolioMapping
