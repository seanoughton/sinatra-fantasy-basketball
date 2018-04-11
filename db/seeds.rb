require './config/environment'

seanoughton = User.create(username: "seanoughton", email: "seanoughton@gmail.com", password: "fantasy")
seanoughton.save

team_curries = Team.create(teamname: "Curries")
team_curries.save

team_brons = Team.create(teamname: "Brons")
team_brons.save

team_westbrooks = Team.create(teamname: "Westbrooks")
team_westbrooks.save

steph_curry = Player.create(playername: "Steph Curry", position: "point guard", fg_perc: "47" , three_pt_perc: "47" , free_throw_perc: "90" , oreb: "12" , reb: "11")

steph_curry.save

