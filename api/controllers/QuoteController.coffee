module.exports = do ->

  QuotesController = {}

  QuotesController.find = (req, res) ->
    symbol = req.query.s or req.query.symbol

    found = (data) ->
      res.ok data

    missing = (data) ->
      res.notFound data

    QuoteService.lookup symbol
      .then found
      .catch missing

  QuotesController
