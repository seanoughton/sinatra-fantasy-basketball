class CreateTeam < ActiveRecord::Migration[5.2]
  def change
  	create_table :teams do |t|
  		t.string :teamname
  		t.integer :user_id
  	end
  end
end
