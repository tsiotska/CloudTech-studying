"use strict";

var _interopRequireDefault = require("@babel/runtime/helpers/interopRequireDefault");

var _express = _interopRequireDefault(require("express"));

var _httpErrors = _interopRequireDefault(require("http-errors"));

var _path = _interopRequireDefault(require("path"));

var _cookieParser = _interopRequireDefault(require("cookie-parser"));

var _morgan = _interopRequireDefault(require("morgan"));

var _users = _interopRequireDefault(require("./routes/users.js"));

// import {setUpDBConnection} from "./database.js";
var master = (0, _express["default"])();
master.use((0, _morgan["default"])('dev'));
master.use(_express["default"].json());
master.use(_express["default"].urlencoded({
  extended: false
}));
master.use((0, _cookieParser["default"])());
master.use(_express["default"]["static"](_path["default"].join(__dirname, 'public'))); // In this master i dont have view, i'm goint to use frontend framework
// Test route

master.use('/', function (req, res) {
  var superTestObj = {
    superTestKey: "I am your super test data!"
  };
  res.send(superTestObj);
});
master.use('/users', _users["default"]); // catch 404 and forward to error handler

master.use(function (req, res, next) {
  next((0, _httpErrors["default"])(404));
}); // error handler

master.use(function (err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};
  res.status(err.status || 500);
});
module.exports = master;