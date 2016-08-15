class AddColorToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :color, :string
  end
end
