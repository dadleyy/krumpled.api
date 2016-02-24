module.exports.policies = (function() {

  var config = {
    "*": ["session"],
    "SystemController": {
      "info": []
    },
    "SessionController": {
      "create": [],
      "destroy": []
    },
    "UserController": {
      "create": []
    }
  };

  return config;

})();
