module.exports.policies = (function() {

  var config = {
    "*": ["session"],
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
