# King behavior.
class King < Piece
  # Capture, check, and checkmate logic are not
  # implemented yet and thus ignored. Obstruction
  # logic is not necessary for the king.
  def valid_move?(x, y)
    moved?(x, y) && radial_move?(x, y) && !checked_cell?(x, y) &&
      (!game.black_check? || !game.white_check?)
  end

  private

  # Returns true if the provided coordinates are within
  # 1 adjacent space of the king in any direction.
  def radial_move?(x, y)
    x_distance(x) <= 1 && y_distance(y) <= 1
  end

  # returns true if the provided coords are on the line of
  # attack of any of the enemy piece.
  def checked_cell?(x, y)
    if color == 'white'
      game.pieces.select {|p| p.color == 'black'}.each do |p|
        if p.valid_move?(x, y)
          return true
        end
      end
    elsif color == 'black'
      game.pieces.select {|p| p.color == 'white'}.each do |p|
        if p.valid_move?(x, y)
          return true
        end
      end
    end
    false
  end
end
