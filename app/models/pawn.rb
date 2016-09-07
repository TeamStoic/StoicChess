# Pawn behavior.
class Pawn < Piece
  # Returns true if the pawn made a valid upgraded forward
  # move on its first move, or a regular forward move, or
  # a capture by attacking diagonally. Ensures no capture
  # takes place by moving forward. Check, and checkmate logic
  # are not implemented yet and thus ignored.
  def valid_move?(x, y)
    return true if diagonal_attack?(x, y)
    return false if game.tile_occupied?(x, y)
    moved ? forward_march?(x, y) : first_move_march?(x, y)
  end

  # Updates the piece's type from Pawn to the new type
  # provided.
  def promote!(new_type)
    options = %w(Bishop Knight Queen Rook)
    raise ArgumentError unless options.include?(new_type)
    update(type: new_type)
  end

  private

  # Returns true if the coordinates provided are 1 tile forward
  # from the piece's origin and no capture occured.
  def forward_march?(x, y)
    if color == 'black'
      x_distance(x).zero? && y == y_position + 1
    else
      x_distance(x).zero? && y == y_position - 1
    end
  end

  # Returns true if coordinates provided are 2 tiles forward
  # from the piece's origin and no capture occurred.
  def clear_two_forward_march?(x, y)
    if color == 'black'
      x_distance(x).zero? && y == y_position + 2 && path_clear?(x, y, 2)
    else
      x_distance(x).zero? && y == y_position - 2 && path_clear?(x, y, 2)
    end
  end

  # Returns true if the coordinates provided
  # are 1-2 tiles forward from the piece's origin.
  def first_move_march?(x, y)
    forward_march?(x, y) || clear_two_forward_march?(x, y)
  end

  # Returns true if pawn is moving into an enemy-occupied tile
  # that is one space diagonally forward to the left or right
  # of the pawn's starting position.
  def diagonal_attack?(x, y)
    return false unless capturable?(x, y)
    x_check = (x == x_position + 1 || x == x_position - 1)
    y_check = y == if color == 'black'
                     y_position + 1
                   else
                     y_position - 1
                   end
    x_check && y_check
  end
end
