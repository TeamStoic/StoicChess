class AddLastMovedPieceToPiecesTable < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :last_moved_piece, :integer
  end
end
