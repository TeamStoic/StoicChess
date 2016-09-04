# Knight behavior.
class Knight < Piece
  # There is no obstruction logic necessary for the knight.
  def valid_move?(x, y)
    tile_empty_or_capturable?(x, y) && l_shaped_move?(x, y)
  end

  # Returns true if the coordinates provided are either
  # 2 tiles away from the x_position along the x_axis and
  # 1 tile away from the y_position along the y_axis OR 1 tile
  # away from the x_position along the x_axis and 2 tiles
  # away from the y_position along the y_axis
  def l_shaped_move?(x, y)
    return false unless moved_from_origin?(x, y)
    (x_distance(x) == 2 && y_distance(y) == 1) ||
      (x_distance(x) == 1 && y_distance(y) == 2)
  end
end
