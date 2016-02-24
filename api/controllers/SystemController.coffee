module.exports = do ->

  SystemController = {}

  SystemController.info = (req, res) ->
    info =
      time: new Date()

    res.ok info
  
  SystemController
