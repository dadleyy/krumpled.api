module.exports = do ->

  modelError = (err) ->
    error_data = err.toJSON()
    fields = (k for k, v of error_data.invalidAttributes)
    @res.badRequest {fields: fields}

  modelError
