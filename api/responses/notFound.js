(function() {

  function missing(data, options) {
    var req = this.req,
        res = this.res;


    return res.status(404).send("not found");
  }

  module.exports = missing;

})();
