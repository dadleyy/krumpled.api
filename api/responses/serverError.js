(function() {

  function error(data, options) {
    var req = this.req,
        res = this.res;


    return res.status(500).send("");
  }

  module.exports = error;

})();
