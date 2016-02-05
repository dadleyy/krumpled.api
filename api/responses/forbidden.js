(function() {

  function forbidden(data, options) {
    var req = this.req,
        res = this.res;


    return res.status(401).send("forbidden");
  }

  module.exports = forbidden;

})();
