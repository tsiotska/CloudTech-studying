db.createUser({
  user: 'root',
  pwd: '1111',
  roles: [
    {
      role: 'dbOwner',
      db: 'users'
    },
  ],
});
