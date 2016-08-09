# game model 
class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :winning_player
      t.string :game_status

      t.integer :counter
      t.integer :turn
      t.integer :user_id
      t.integer :player_id



      t.timestamps null: false
    end
  end
end
