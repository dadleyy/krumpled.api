module.exports = do ->

  SymbolController = {}

  upper = (str) -> str.toUpperCase?()

  SymbolController.find = (req, res) ->
    res.noContent()

  SymbolController.findOne = (req, res) ->
    symbol_id = req.params.id

    found = (err, symbol) ->
      return res.notFound 1 if err
      return res.notFound 2 unless symbol
      res.ok symbol

    Symbol.findOne {id: symbol_id}, found

  SymbolController.create = (req, res) ->
    res.noContent()

  SymbolController.update = (req, res) ->
    res.noContent()

  SymbolController.destroy = (req, res) ->
    res.noContent()

  SymbolController
