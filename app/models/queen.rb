# Queen behavior.
class Queen < Piece
  # Capture, check, and checkmate logic are not
  # implemented yet and thus ignored.
  def valid_move?(x, y)
    return false unless tile_empty_or_capturable?(x, y)
    clear_horizontal_move?(x, y) ||
      clear_vertical_move?(x, y) ||
      clear_diagonal_move?(x, y)
  end
end
