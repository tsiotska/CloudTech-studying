"use strict";

var _interopRequireDefault = require("@babel/runtime/helpers/interopRequireDefault");

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.closeDataBase = closeDataBase;
exports.dbUrl = void 0;
exports.setUpDBConnection = setUpDBConnection;

var _mongoose = _interopRequireDefault(require("mongoose"));

var dbUrl = 'mongodb://localhost:27017/users';
exports.dbUrl = dbUrl;

function setUpDBConnection() {
  _mongoose["default"].connect(dbUrl).then(function () {
    console.log("DataBase is connected: " + dbUrl);
  })["catch"](function (err) {
    console.log('Error on database: ' + err.stack);
    process.exit(1);
  });
}

function closeDataBase() {
  _mongoose["default"].connection.close();
}