(function() {

  function ok(data, options) {
    var req = this.req,
        res = this.res;


    return res.status(200).json(data);
  }

  module.exports = ok;

})();
