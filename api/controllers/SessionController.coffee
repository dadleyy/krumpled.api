Bcrypt = require "../services/Bcrypt"

module.exports = do ->

  SessionController = {}

  SessionController.create = (req, res) ->
    email = req.body?.email
    password = req.body?.password
    found_user = null

    compared = (err, did_match) ->
      return res.notFound "1" if err or not did_match
      req.session.user = found_user.id
      res.ok {"session": true}

    foundUser = (err, user) ->
      return res.serverError() if err
      return res.notFound() if not user
      found_user = user
      Bcrypt.compare password, user.password, compared

    (User.findOne {email: email}).exec foundUser

  SessionController.current = (req, res) ->
    user_id = req.session?.user

    foundUser = (err, user) ->
      return res.serverError() if err
      res.ok user

    User.findOne {
      id: user_id
    }, foundUser

  SessionController.destroy = (req, res) ->
    req.session.user = null
    res.noContent()

  SessionController
