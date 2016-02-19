bcrypt = require "bcrypt"

module.exports = do ->

  Bcrypt = {}

  Bcrypt.encrypt = (in_str, callback) ->
    bcrypt.hash in_str, 8, callback

  Bcrypt.compare = (str_a, str_b, callback) ->
    bcrypt.compare str_a, str_b, callback

  Bcrypt
