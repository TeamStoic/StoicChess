# All validation assumes white player is on the
# 6-7 rows of the array, and black player is on
# 0-1 rows of the array.
class Piece < ActiveRecord::Base
  belongs_to :game
  belongs_to :player
  validates :color, inclusion: { in: %w(black white) }
  validates :type, inclusion: { in: %w(Pawn Rook Bishop Knight King Queen) }

  # Returns true and upates the piece's coordinates and moved
  # flag on a valid move where the tile is either empty or
  # occupied by an enemy piece.  Executes capture method
  # on enemy occupying piece.  Otherwise returns false
  # and no further changes are made.
  def move!(x, y)
    return false unless valid_move?(x, y)
    return false if king_exposed?(x, y)
    capture!(x, y)
    update(x_position: x, y_position: y, moved: true)
    game.next_turn
    true
  end

  def generate_valid_moves
    moveset_tiles = []
    game.generate_tiles.each do |tile|
      moveset_tiles << tile if valid_move?(tile[0], tile[1])
    end
    moveset_tiles
  end

  private

  # Updates a victim piece to nil coordinates and sets
  # captured flag to true.
  def capture!(x, y)
    victim = game.tile_occupant(x, y)
    victim.update(x_position: nil, y_position: nil, captured: true) if victim
  end

  def capturable?(x, y)
    player.enemy.pieces.exists?(x_position: x, y_position: y)
  end

  def tile_empty_or_capturable?(x, y)
    !game.tile_occupied?(x, y) || capturable?(x, y)
  end

  def king_exposed?(x, y)
    original_x = x_position
    original_y = y_position
    update(x_position: x, y_position: y)
    exposed = player.king.in_check?
    update(x_position: original_x, y_position: original_y)
    exposed
  end

  # Compares a piece's x_position with the
  # coordinate provided and returns the
  # distance between the two.
  def x_distance(new_x_coordinate)
    (x_position - new_x_coordinate).abs
  end

  # Compares a piece's y_position with the
  # coordinate provided and returns the
  # distance between the two.
  def y_distance(new_y_coordinate)
    (y_position - new_y_coordinate).abs
  end

  # Returns true if the coordinates provided
  # are different from the piece's starting position.
  def moved_from_origin?(x, y)
    x != x_position || y != y_position
  end

  # Returns true if the coordinates provided have the
  # same x-axis value and there are no pieces in between.
  def clear_horizontal_move?(x, y)
    return false unless moved_from_origin?(x, y)
    return false unless y_distance(y).zero?
    distance = x_distance(x)
    path_clear?(x, y, distance)
  end

  # Returns true if the coordinates provided have
  # the same y-axis value and there are no pieces in between.
  def clear_vertical_move?(x, y)
    return false unless moved_from_origin?(x, y)
    return false unless x_distance(x).zero?
    distance = y_distance(y)
    path_clear?(x, y, distance)
  end

  # Returns true if the coordinates provided
  # are the same distance away from the origin point along
  # both axis and there are no pieces in between.
  def clear_diagonal_move?(x, y)
    return false unless moved_from_origin?(x, y)
    return false unless x_distance(x) == y_distance(y)
    distance = x_distance(x)
    path_clear?(x, y, distance)
  end

  # Returns a hash with 1 or -1 values for
  # x and y based on whether those values are
  # increasing or decreasing towards destination
  # to determine direction of path along both axis.
  def path_direction(x, y)
    direction = {}
    direction[:x] = if x_position < x then 1
                    elsif x_position > x then -1
                    else 0
                    end
    direction[:y] = if y_position < y then 1
                    elsif y_position > y then -1
                    else 0
                    end
    direction
  end

  # Returns an array of x-y coordinate subarrays
  # between origin and destination.
  def generate_path(x, y, distance)
    path = []
    direction = path_direction(x, y)
    (distance - 1).times do |i|
      i += 1
      path << [
        x_position + i * direction[:x],
        y_position + i * direction[:y]
      ]
    end
    path
  end

  # Returns true if no x-y coordinate pairs between
  # origin and destination have a piece present.
  def path_clear?(x, y, distance)
    path = generate_path(x, y, distance)
    path.each do |tile|
      return false if game.pieces.exists?(
        x_position: tile[0],
        y_position: tile[1]
      )
    end
    true
  end
end
