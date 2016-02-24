module.exports = do ->

  ResponseFactory = (code, status_string, transform) ->

    handler = (result, meta) ->
      request_response = @res
      response = {"status": "#{code} #{status_string}"}
      response.result = result if result
      response.meta = meta if meta

      send = (err, final_result) ->
        (request_response.status code).json final_result

      (transform? result, options, send) or send false, response

    handler

  ResponseFactory
