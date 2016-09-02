# King behavior.
class King < Piece
  # Capture, check, and checkmate logic are not
  # implemented yet and thus ignored. Obstruction
  # logic is not necessary for the king.
  def valid_move?(x, y)
    moved?(x, y) && radial_move?(x, y) && !check_state(x, y, color)
  end

  private

  # Returns true if the provided coordinates are within
  # 1 adjacent space of the king in any direction.
  def radial_move?(x, y)
    x_distance(x) <= 1 && y_distance(y) <= 1
  end
end
