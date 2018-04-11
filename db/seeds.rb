require './config/environment'

seanoughton = User.create(username: "seanoughton", email: "seanoughton@gmail.com", password: "fantasy")
seanoughton.save

warriors = Team.create(teamname: "Warriors")
warriors.save

cavaliers = Team.create(teamname: "Cavaliers")
cavaliers.save

okc = Team.create(teamname: "OKC")
okc.save

steph_curry = Player.create(playername: "Steph Curry", position: "point guard", fg_perc: "47" , three_pt_perc: "47" , free_throw_perc: "90" , oreb: "12" , reb: "11")
steph_curry.save

klay_thompson = Player.create(playername: "Klay Thompson", position: "shooting guard", fg_perc: "47" , three_pt_perc: "47" , free_throw_perc: "90" , oreb: "12" , reb: "11")
klay_thompson.save

kevin_durant = Player.create(playername: "Kevin Durant", position: "small forward", fg_perc: "47" , three_pt_perc: "47" , free_throw_perc: "90" , oreb: "12" , reb: "11")
kevin_durant.save

draymond_green = Player.create(playername: "Draymond Green", position: "power forward", fg_perc: "47" , three_pt_perc: "47" , free_throw_perc: "90" , oreb: "12" , reb: "11")
draymond_green.save

zaza_pachulia = Player.create(playername: "Zaza Pachulia", position: "center", fg_perc: "47" , three_pt_perc: "47" , free_throw_perc: "90" , oreb: "12" , reb: "11")
zaza_pachulia.save

warriors.players << steph_curry
warriors.players << klay_thompson
warriors.players << kevin_durant
warriors.players << draymond_green
warriors.players << zaza_pachulia

