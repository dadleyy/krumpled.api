bluebird = require "bluebird"

module.exports = do ->

  SymbolController = {}

  upper = (str) -> str.toUpperCase?()

  sanitize = (str) ->
    "#{str}".replace /([^A-z0-9])/g, ""

  SymbolController.find = (req, res) ->
    [page, limit] = [(req.query.page or 0), (req.query.limit or 10)]

    unless page >= 1
      page = 0

    unless limit >= 1 and limit < 100
      limit = 10

    loaded = (results) ->
      [symbols, total] = results
      res.ok symbols, {total: total}

    failed = (err) ->
      res.badRequest err

    cursor = Symbol.find()

    if req.query.symbol
      req.query.symbol.like = "%#{sanitize req.query.symbol.like}%" if req.query.symbol.like
      cursor.where {symbol: req.query.symbol}

    cursor.paginate
      page: page
      limit: limit

    (bluebird.all [
      cursor
      Symbol.count()
    ]).then loaded
      .catch failed

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
