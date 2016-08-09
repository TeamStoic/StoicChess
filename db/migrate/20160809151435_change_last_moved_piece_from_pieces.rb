class ChangeLastMovedPieceFromPieces < ActiveRecord::Migration[5.0]
  def change
    rename_column :pieces, :last_moved_piece, :turn_last_moved
  end
end
