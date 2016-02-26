xml = require "xml"
xpath = require "xpath"
xmldom = require "xmldom"
http = require "http"
https = require "https"
bluebird = require "bluebird"

module.exports = do ->

  QuoteService = {}

  QUOTE_API_HOST = "iphone-wu.apple.com"
  QUOTE_API_PORT = 80
  QUOTE_API_PATH = process.env["QUOTE_API_PATH"]
  QUOTE_API_CLIENT_ID = process.env["QUOTE_API_CLIENT_ID"]
  QUOTE_API_USER_AGENT = process.env["QUOTE_API_USER_AGENT"]

  lower = (s) -> s?.toLowerCase?()
  upper = (s) -> s?.toUpperCase?()

  DATA_PARTS = [
    "name", "symbol", "price"
    "currency", "change", "changepercent"
    "marketcap", "status", "realtimets",
    "realtimeprice", "realtimechange"
    "high", "low", "open", "dividendyield"
    "peratio", "volume", "averagedailyvolume"
    "yearrange", "exchange"
  ]

  extractor = (node) ->
    extract = (child_tag) ->
      child_node = (node.getElementsByTagName child_tag).item 0
      child_node?.textContent
    extract

  cleanExchangeName = (name) ->
    chars_only = name.replace /[^A-Za-z]/g, ""
    upper chars_only

  parseResponse = (response_text) ->
    dom = new xmldom.DOMParser().parseFromString response_text
    quotes = dom.getElementsByTagName "quote"

    quote_info = []
 
    extract = (quote) ->
      text_extract = extractor quote

      data =
        price: text_extract "price"
        volume: text_extract "volume"
        symbol: text_extract "symbol"
        name: text_extract "name"
        exchange: text_extract "exchange"
        change: text_extract "change"
        dividendyield: text_extract "dividendyield"

      if data.price then data else false

    for q in quotes
      q_data = extract q
      quote_info.push q_data if q_data

    if quote_info.length > 0 then quote_info else false


  requestBody = (symbol) ->
    body = {}
    symbol = if symbol instanceof Array then symbol else [symbol]

    request_attrs =
      _attr:
        devtype: "Apple iPhone v6.1.3"
        deployver: "Apple iPhone v6.1.3"
        app: "YGoiPhoneClient"
        appver: "1.0.1.10B329"
        api: "finance"
        apiver: "1.0.1"
        acknotification: "0000"

    query_attrs =
      _attr:
        id: 0
        type: "getquotes"

    symbol_list = ({symbol: s} for s in symbol)

    query =
      query: [
        query_attrs
        {list: symbol_list}
        {parts: DATA_PARTS.join ","}
      ]

    body.request = [
      request_attrs
      query
    ]

    "<?xml version=\"1.0\" encoding=\"utf-8\"?>#{xml body}"

  QuoteService.lookup = (symbol, callback, save_results=false) ->
    [resolve, reject] = [null, null]
    deferred = new bluebird (fns...) -> [resolve, reject] = fns
    response = ""
    request_body = requestBody symbol
    quote_result = null

    headers =
      "Content-Type": "text/xml"
      "X-Client-ID": QUOTE_API_CLIENT_ID
      "User-Agent": QUOTE_API_USER_AGENT

    request_config =
      host: QUOTE_API_HOST
      port: QUOTE_API_PORT
      path: QUOTE_API_PATH
      method: "POST"
      headers: headers

    finishedAll = (histories) ->
      resolve quote_result

    createHistory = (symbols) ->
      history_load = null
      timestamp = new Date()

      createHistory = (quote) ->
        quote.id = (s for s in symbols when s.symbol == q.symbol)[0]?.id or false

        history_data =
          symbol: q.id
          volume: q.volume
          price: q.price
          date: timestamp

        if save_results then SymbolPriceHistory.create history_data else bluebird.resolve true

      history_load = (createHistory q for q in quote_result)
      
      bluebird.all history_load
        .then finishedAll
        .catch failedSymbols

    failedSymbols = (e) ->
      reject new Error "symbol_lookup"

    loadedExchanges = (results) ->
      symbol_lookups = []

      for q in quote_result
        exchange = (e for e in results when (upper e.name) == (upper q.exchange))[0]
        continue if not exchange

        lookup = Symbol.findOrCreate {
          symbol: upper q.symbol
          exchange: exchange.id
        }, {
          symbol: upper q.symbol
          exchange: exchange.id
          full_name: q.name
        }

        symbol_lookups.push lookup

      bluebird.all symbol_lookups
        .then createHistory
        .catch failedSymbols

    failedExchanges = ->
      reject new Error "exhange_lookup"

    finish = ->
      quote_result = parseResponse response
      exchanges = []

      unless quote_result
        return reject new Error "quote_api_response"

      for q in quote_result
        exchange_name = cleanExchangeName q.exchange
        exchanges.push exchange_name if (exchanges.indexOf exchange_name) == -1

      exchange_lookups = []

      for e in exchanges
        lookup = Exchange.findOrCreate {name: e}, {name: e}
        exchange_lookups.push lookup

      bluebird.all exchange_lookups
        .then loadedExchanges
        .catch failedExchanges

    receive = (data) ->
      response += data

    errored = ->
      reject new Error "quote_api_socket"

    connected = (response) ->
      return reject new Error "quote_api_status_code" if response.statusCode != 200
      response.on "data", receive
      response.on "end", finish

    request_fn = (if true then http else https).request

    try
      request = request_fn request_config, connected
      request.write request_body
      request.end()
      request.on "error", errored
    catch e
      reject new Error "quote_api_connect"

    deferred

  QuoteService
