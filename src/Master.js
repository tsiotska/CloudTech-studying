import express from 'express';
import {setUpDBConnection} from "./database.js";
import createError from 'http-errors';
import path from 'path';
import cookieParser from 'cookie-parser';
import logger from 'morgan';
import usersRouter from './routes/users.js';

const master = express();

master.use(logger('dev'));
master.use(express.json());
master.use(express.urlencoded({extended: false}));
master.use(cookieParser());
master.use(express.static(path.join(__dirname, 'public')));

// In this master i dont have view, i'm goint to use frontend framework
// Test route
master.use('/', (req, res) => {
  const superTestObj = {superTestKey: "I am your super test data!"};
  res.send(superTestObj);
});

master.use('/users', usersRouter);

// catch 404 and forward to error handler
master.use(function (req, res, next) {
  next(createError(404))
});

// error handler
master.use(function (err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};
  res.status(err.status || 500);
});

setUpDBConnection();

module.exports = master;
