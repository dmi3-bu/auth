p 'Creating seeds...'
users = User.create!([
 {
   name: 'Bob',
   email: 'bob@example.com',
   password: 'givemeatoken'
 },
 {
   name: 'Alice',
   email: 'alice@example.com',
   password: 'newpasword'
 },
 {
   name: 'Charlie',
   email: 'charlie@example.com',
   password: '12345'
 }
])
sessions = UserSession.create!([
 {
   user: users.first
 },
 {
   user: users.second
 },
 {
   user: users.second
 },
])