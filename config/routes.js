module.exports.routes = (function() {

  var routes = {
    "GET /system": "SystemController.info",

    "get /session": "SessionController.current",
    "POST /session": "SessionController.create",
    "DELETE /session": "SessionController.destroy",
    "GET /logout": "SessionController.destroy",

    "GET /users": "UserController.find",
    "POST /users": "UserController.create",
    "PUT /users/:id": "UserController.update",
    "DELETE /users/:id": "UserController.destroy",

    "GET /portfolios": "PortfolioController.find",
    "POST /portfolios": "PortfolioController.create",
    "PUT /portfolios/:id": "PortfolioController.update",
    "DELETE /portfolios/:id": "PortfolioController.destroy",

    "GET /trades": "TradeController.find",
    "POST /trades": "TradeController.create",
    "PUT /trades/:id": "TradeController.update",
    "DELETE /trades/:id": "TradeController.destroy",

    "GET /symbols": "SymbolController.find",
    "GET /symbols/:id": "SymbolController.findOne",
    "POST /symbols": "SymbolController.create",
    "PUT /symbols/:id": "SymbolController.update",
    "DELETE /symbols/:id": "SymbolController.destroy",

    "GET /quotes": "QuoteController.find"
  };

  return routes;

})();
