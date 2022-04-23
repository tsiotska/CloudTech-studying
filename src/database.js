import mongoose from 'mongoose';

export const dbUrl = 'mongodb://mongo:27017/users';

export function setUpDBConnection() {
  mongoose.connect(dbUrl)
    .then(() => {
      console.log("DataBase is connected: " + dbUrl);
    })
    .catch((err) => {
      console.log('Error on database: ' + err.stack);
      process.exit(1);
    });
}

export function closeDataBase() {
  mongoose.connection.close();
}


