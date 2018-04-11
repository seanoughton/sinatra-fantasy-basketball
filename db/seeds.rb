require './config/environment'

seanoughton = User.create(username: "seanoughton", email: "seanoughton@gmail.com", password: "fantasy")
seanoughton.save