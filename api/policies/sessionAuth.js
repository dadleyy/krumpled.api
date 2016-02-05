(function() {

  function sessionAuth(req, res, next) {
    if(req.session.authenticated)
      return next();

    return res.forbidden();
  }

  module.exports = sessionAuth;

})();

