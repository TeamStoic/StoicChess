class AddEnPassantToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :en_passant, :boolean, default: false
  end
end
