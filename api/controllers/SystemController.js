(function() {

  var SystemController = {};

  SystemController.info = function(req, res) {
    return res.json({
      time: new Date()
    });
  };


  module.exports = SystemController;

})();
