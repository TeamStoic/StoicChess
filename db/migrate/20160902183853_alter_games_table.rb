class AlterGamesTable < ActiveRecord::Migration[5.0]
  def change
    change_column_default :games, :turn, from: nil, to: 1
    remove_column :games, :counter
    remove_column :games, :winning_player
    remove_column :games, :game_status
  end
end
