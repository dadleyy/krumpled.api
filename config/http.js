(function() {

  var config = {

    middleware: {
      order: [
        'startRequestTimer',
        'cookieParser',
        'session',
        'myRequestLogger',
        'bodyParser',
        'handleBodyParserError',
        'compress',
        'methodOverride',
        'poweredBy',
        '$custom',
        'router',
        'www',
        'favicon',
        '404',
        '500'
      ]
    }

  };

  module.exports.http = config;

})();
