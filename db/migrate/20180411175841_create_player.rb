class CreatePlayer < ActiveRecord::Migration[5.2]
  def change
  	create_table :players do |t|
  		t.string :playername
  		t.string :position
  		t.integer :fg_perc
  		t.integer :three_pt_perc
  		t.integer :free_throw_perc
  		t.integer :oreb
  		t.integer :reb
  		t.integer :team_id
  	end
  end
end
