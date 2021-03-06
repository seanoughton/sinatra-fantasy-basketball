CSV.foreach("db/csv/all_players.csv") do |row|
  			new_player = Player.create(
  				rank: row[0],
  				playername: row[1], 
  				position: row[2],
  				age: row[3],
  				originalteam: row[4], 
  				fg_perc: row[5], 
  				three_pt_perc: row[6], 
  				two_pt_perc: row[7],
  				free_throw_perc: row[8], 
  				oreb: row[9], 
  				reb: row[10],
  				assists: row[11],
  				steals: row[12],
  				blocks: row[13],
  				turnovers: row[14],
  				ps_per_game: row[15])
  			new_player.save
		end