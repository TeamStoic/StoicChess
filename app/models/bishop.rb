# Bishop behavior.
class Bishop < Piece
  # Capture, check, and checkmate logic are not
  # implemented yet and thus ignored.
  def valid_move?(x, y)
    tile_empty_or_capturable?(x, y) && clear_diagonal_move?(x, y)
  end
end
