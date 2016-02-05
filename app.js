process.chdir(__dirname);

(function() {
  var sails;

  try {
    sails = require('sails');
  } catch (e) {
    console.error("missing sails npm module, perhaps forgot to run \"npm install\".");
    return;
  }

  var rc;

  try {
    rc = require('rc');
  } catch (e0) {
    try {
      rc = require('sails/node_modules/rc');
    } catch (e1) {
      console.error(".sailsrc files will be ignored - no \"rc\" module found");
      rc = function () { return {}; };
    }
  }

  sails.lift(rc('sails'));

})();
