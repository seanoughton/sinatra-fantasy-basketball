ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'
require 'csv'

desc 'seeds_the_db_from_csv'
task :seed_db do
	filename = File.dirname(File.dirname(File.expand_path(__FILE__))) + '/fantasy-basketball/db/csv/players.csv'
  		CSV.foreach(filename) do |row|
  			new_player = Player.create(playername: row[0], position: row[1], fg_perc: row[2], three_pt_perc: row[3], free_throw_perc: row[4], oreb: row[5], reb: row[6])
  			new_player.save
		end
end
