class ChangeTurnFromGames < ActiveRecord::Migration[5.0]
  def change
    remove_column :games, :turn, :integer
    remove_column :games, :move_number, :integer
  end
end
