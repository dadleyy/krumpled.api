(function() {

  var config = {
    allRoutes: false,
    origin: '*',
    credentials: true,
    methods: 'GET, POST, PUT, DELETE, OPTIONS, HEAD',
    headers: 'content-type'
  };

  module.exports.cors = config;

})();
