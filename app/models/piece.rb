# Piece superset behavior.
class Piece < ActiveRecord::Base
  belongs_to :game
  belongs_to :player

  validates :color, inclusion: { in: %w(black white) }
  validates :type, inclusion: { in: %w(Pawn Rook Bishop Knight King Queen) }

  # Returns true, updates the piece's x and y position
  # to provided coordinates if move is valid, and sets
  # the moved flag to true otherwise do nothing and
  # return false.
  def move!(x, y)
    return false unless valid_move?(x, y)
    self.x_position = x
    self.y_position = y
    self.moved = true
    true
  end

  # All validation assumes white player is on the
  # 6-7 rows of the array, and black player is on
  # 0-1 rows of the array.

  private

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
  # are different from the piece's starting
  # position.
  def moved?(x, y)
    x != x_position || y != y_position
  end

  # Returns true if the coordinates provided
  # have the same x-axis value and there are no
  # pieces in between.
  def horizontal_move?(x, y)
    return false unless y_distance(y) == 0
    x_range = (x_position + 1)...x if x_position < x # right
    x_range = (x + 1)...x_position if x_position > x # left
    x_range.each do |x_check|
      return false if game.pieces.find_by(x_position: x_check, y_position: y)
    end
    true
  end

  # Returns true if the coordinates provided
  # have the same y-axis value and there are no
  # pieces in between.
  def vertical_move?(x, y)
    return false unless x_distance(x) == 0
    y_range = (y_position + 1)...y if y_position < y # down
    y_range = (y + 1)...y_position if y_position > y # up
    y_range.each do |y_check|
      return false if game.pieces.find_by(x_position: x, y_position: y_check)
    end
    true
  end

  # Returns true if the coordinates provided
  # are the same distance away from the
  # origin point along both axis.
  def diagonal_move?(x, y)
    return false unless x_distance(x) == y_distance(y)
    if y_position < y && x_position < x
      bottom_right_check?(x, y)
    elsif y_position > y && x_position > x
      top_left_check?(x, y)
    elsif y_position < y && x_position > x
      bottom_left_check?(x, y)
    else
      top_right_check?(x, y)
    end
  end

  def bottom_right_check?(x, y)
    x_check = x_position
    y_check = y_position
    (x_distance(x) - 1).times do
      x_check += 1
      y_check += 1
      return false if game.pieces.find_by(x_position: x_check, y_position: y_check)
    end
    true
  end

  def top_left_check?(x, y)
    x_check = x_position
    y_check = y_position
    (x_distance(x) - 1).times do
      x_check -= 1
      y_check -= 1
      return false if game.pieces.find_by(x_position: x_check, y_position: y_check)
    end
    true
  end

  def bottom_left_check?(x, y)
    x_check = x_position
    y_check = y_position
    (x_distance(x) - 1).times do
      x_check -= 1
      y_check += 1
      return false if game.pieces.find_by(x_position: x_check, y_position: y_check)
    end
    true
  end

  def top_right_check?(x, y)
    x_check = x_position
    y_check = y_position
    (x_distance(x) - 1).times do
      x_check += 1
      y_check -= 1
      return false if game.pieces.find_by(x_position: x_check, y_position: y_check)
    end
    true
  end
end
