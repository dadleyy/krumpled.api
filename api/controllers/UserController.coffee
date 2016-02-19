Bcrypt = require "../services/Bcrypt"

module.exports = do ->

  UserController = {}

  UserController.find = (req, res) ->
    res.noContent()

  UserController.create = (req, res) ->
    email = req.body?.email
    password = req.body?.password
    username = req.body?.username
    full_name = req.body?.full_name

    if not password
      return res.badRequest {fields: "password_missing"}

    failed = (err) ->
      res.modelError err

    finished = (err, new_user) ->
      return failed err if err
      res.ok new_user

    createUser = (err, enc_password) ->
      return res.serverError() if err

      User.create {
        email: email
        password: enc_password
        username: username
        full_name: full_name
      }, finished
  
    Bcrypt.encrypt password, createUser

  UserController.update = (req, res) ->
    res.noContent()

  UserController.destroy = (req, res) ->
    res.noContent()

  UserController
