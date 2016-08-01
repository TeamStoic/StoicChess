# Pawn behavior.
class Pawn < Piece
  # Returns true if the pawn made a valid upgraded forward
  # move on its first move, or else a regular forward move,
  # and ensure no capture takes place by moving forward.
  # Check, and checkmate logic are not implemented yet
  # and thus ignored. Diagonal attack not implemented.
  def valid_move?(x, y)
    if moved
      one_fwd_move?(x, y) || fwd_diagonal_attack?(x, y)
    else
      (first_fwd_move?(x, y)) && !fwd_capture?(x, y)) ||
        fwd_diagonal_attack(x, y)
    end
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
  def one_fwd_move?(x, y)
    if color == 'black'
      x_distance(x) == 0 && y == y_position + 1
    else
      x_distance(x) == 0 && y == y_position - 1
    end
  end

  # Returns true if coordinates provided are 2 tiles forward
  # from the piece's origin and no capture occurred.
  def clear_two_fwd_move?(x, y)
    if color == 'black'
      x_distance(x) == 0 && y == y_position + 2 && path_clear?(x, y, 2)
    else
      x_distance(x) == 0 && y == y_position - 2 && path_clear?(x, y, 2)
    end
  end

  # Returns true if the coordinates provided
  # are 1-2 tiles forward from the piece's origin.
  def first_fwd_move?(x, y)
    one_fwd_move?(x, y) || clear_two_fwd_move?(x, y)
  end

  def fwd_capture?(x, y)
    game.pieces.exists?(x_position: x, y_position: y)
  end

  def fwd_diagonal_attack?(x, y)
    return false unless occupant_piece(x, y)
    (x == x_position + 1 || x == x_position - 1) &&
      color == black ? y == y_position + 1 : y == y_position - 1
  end
end
