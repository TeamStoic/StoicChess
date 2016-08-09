class RemoveEnPassantFromGame < ActiveRecord::Migration[5.0]
  def change
    remove_column :games, :en_passant, :boolean
  end
end
