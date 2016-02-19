module.exports = do ->

  sessionPolicy = (req, res, next) ->
    return res.notFound "-1" if not req.session.user >= 1
    next()
  
  sessionPolicy
