(function() {

  function badRequest(data, options) {
    var req = this.req,
        res = this.res;


    return res.status(400).json(data);
  }

  module.exports = badRequest;

})();
