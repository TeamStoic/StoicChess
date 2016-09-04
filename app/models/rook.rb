# Rook behavior.
class Rook < Piece
  # Capture, check, and checkmate logic are not
  # implemented yet and thus ignored.
  def valid_move?(x, y)
    moved?(x, y) && (clear_horizontal_move?(x, y) || clear_vertical_move?(x, y))
  end

  # Updates rook's position to the post-castling
  # position.
  def castling_move
    new_x = x_position.zero? ? 3 : 5
    update(x_position: new_x, moved: true)
  end
end
