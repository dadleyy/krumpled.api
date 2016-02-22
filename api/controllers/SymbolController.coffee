module.exports = do ->


  SymbolController = {}

  SymbolController.find = (req, res) ->
    symbol = req.query.s or req.query.symbol

    found = (data) ->
      res.ok data

    missing = (data) ->
      res.notFound data

    QuoteService.lookup symbol
      .then found
      .catch missing

  SymbolController.create = (req, res) ->
    res.noContent()

  SymbolController.update = (req, res) ->
    res.noContent()

  SymbolController.destroy = (req, res) ->
    res.noContent()

  SymbolController
