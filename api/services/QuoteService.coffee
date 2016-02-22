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
  QUOTE_API_PATH = "/dgw?imei=4087475939882607228&apptype=finance"

  DATA_PARTS = [
    "name", "symbol", "price"
    "currency", "change", "changepercent"
    "marketcap", "status", "realtimets",
    "realtimeprice", "realtimechange"
    "high", "low", "open", "dividendyield"
    "peratio", "volume", "averagedailyvolume"
    "yearrange", "exchange"
  ]

  parseResponse = (response_text) ->
    dom = new xmldom.DOMParser().parseFromString response_text

    quote_info =
      price: (xpath.select "//quote//price/text()", dom).toString()
      name: (xpath.select "//quote//name/text()", dom).toString()
      symbol: (xpath.select "//quote//symbol/text()", dom).toString()
      exchange: (xpath.select "//quote//exchange/text()", dom).toString()
      volume: (xpath.select "//quote//volume/text()", dom).toString()

    quote_info


  requestBody = (symbol) ->
    body = {}

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

    query =
      query: [
        query_attrs
        {list: [{symbol: "#{symbol}".toUpperCase()}]}
        {parts: DATA_PARTS.join ","}
      ]

    body.request = [
      request_attrs
      query
    ]

    "<?xml version=\"1.0\" encoding=\"utf-8\"?>#{xml body}"

  QuoteService.lookup = (symbol, callback) ->
    [resolve, reject] = [null, null]
    deferred = new bluebird (fns...) -> [resolve, reject] = fns
    response = ""
    request_body = requestBody symbol

    headers =
      "Content-Type": "text/xml"
      "X-Client-ID": "IMSI=5115998181642601044"
      "User-Agent": "Apple iPhone v6.1.2 Stocks v3.0.10B146"

    request_config =
      host: QUOTE_API_HOST
      port: QUOTE_API_PORT
      path: QUOTE_API_PATH
      method: "POST"
      headers: headers

    finish = ->
      info = parseResponse response

      if not info
        return reject new Error 13

      resolve info

    receive = (data) ->
      response += data

    errored = ->
      reject new Error 12

    connected = (response) ->
      return reject new Error 11 if response.statusCode != 200
      response.on "data", receive
      response.on "end", finish

    request_fn = (if true then http else https).request

    try
      request = request_fn request_config, connected
      request.write request_body
      request.end()
      request.on "error", errored
    catch e
      reject new Error 10

    deferred

  QuoteService
