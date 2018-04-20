class CreatePlayer < ActiveRecord::Migration[5.2]
  def change
  	create_table :players do |t|
      t.integer :rank
  		t.string :playername
  		t.string :position
      t.integer :age
      t.string :originalteam
  		t.float :fg_perc
  		t.float :three_pt_perc
      t.float :two_pt_perc
  		t.float :free_throw_perc
  		t.float :oreb
  		t.float :reb
      t.float :assists
      t.float :steals
      t.float :blocks
      t.float :turnovers
      t.float :ps_per_game
  		t.integer :team_id
  	end
  end
end
