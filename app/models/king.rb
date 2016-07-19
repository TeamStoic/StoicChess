class King < Piece

  # Capture, collision, check, and checkmate logic are not
  # implemented yet and thus ignored.
  def valid_move?(x, y)
    moved?(x,y) && radial_move?(x,y)
  end

  private

  # Returns true if the provided coordinates are within
  # 1 adjacent space of the king in any direction.
  def radial_move?(x,y)
    x_distance(x) <= 1 && y_distance(y) <= 1
  end

end
