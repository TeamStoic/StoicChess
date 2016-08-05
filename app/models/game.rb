# model Game,piece creation inside
# DO NOT chnage the sequence of methods
# or you will break the front end view
class Game < ActiveRecord::Base
  has_many :pieces
  has_many :players

  def populate!
    populate_left_black_half!
    populate_right_black_half!
    populate_black_pawns!
    populate_white_pawns!
    populate_left_white_half!
    populate_right_white_half!
  end

  private

  def populate_left_black_half!
    pieces.create(type: 'Rook', x_position: 0, y_position: 0, color: 'black')
    pieces.create(type: 'Knight', x_position: 1, y_position: 0, color: 'black')
    pieces.create(type: 'Bishop', x_position: 2, y_position: 0, color: 'black')
    pieces.create(type: 'Queen', x_position: 3, y_position: 0, color: 'black')
  end

  def populate_right_black_half!
    pieces.create(type: 'King', x_position: 4, y_position: 0, color: 'black')
    pieces.create(type: 'Bishop', x_position: 5, y_position: 0, color: 'black')
    pieces.create(type: 'Knight', x_position: 6, y_position: 0, color: 'black')
    pieces.create(type: 'Rook', x_position: 7, y_position: 0, color: 'black')
  end

  def populate_black_pawns!
    (0..7).each do |i|
      pieces.create(type: 'Pawn', x_position: i, y_position: 1, color: 'black')
    end
  end

  def populate_white_pawns!
    (0..7).each do |j|
      pieces.create(type: 'Pawn', x_position: j, y_position: 6, color: 'white')
    end
  end

  def populate_left_white_half!
    pieces.create(type: 'Rook', x_position: 0, y_position: 7, color: 'white')
    pieces.create(type: 'Knight', x_position: 1, y_position: 7, color: 'white')
    pieces.create(type: 'Bishop', x_position: 2, y_position: 7, color: 'white')
    pieces.create(type: 'Queen', x_position: 3, y_position: 7, color: 'white')
  end

  def populate_right_white_half!
    pieces.create(type: 'King', x_position: 4, y_position: 7, color: 'white')
    pieces.create(type: 'Bishop', x_position: 5, y_position: 7, color: 'white')
    pieces.create(type: 'Knight', x_position: 6, y_position: 7, color: 'white')
    pieces.create(type: 'Rook', x_position: 7, y_position: 7, color: 'white')
  end

  def check?
   white_king = pieces.find_by(type: 'King', color: "white")
   black_king = pieces.find_by(type: 'King', color: "black")

    wht_x = white_king.x_position
    wht_y = white_king.y_position
    blk_x = black_king.x_position
    blk_y = black_king.y_position

    pieces.each do |piece|
      if piece.enemy?(white_king) &&
        piece.clear_diagonal_move?(wht_x, wht_y) ||
        piece.clear_vertical_move?(wht_x, wht_y) ||
        piece.clear_horizontal_move?(wht_x, wht_y)
        return true
      elsif piece.enemy?(black_king)
        piece.clear_diagonal_move?(blk_x, blk_y) ||
        piece.clear_vertical_move?(blk_x, blk_y) ||
        piece.clear_horizontal_move?(blk_x, blk_y)
        return true
      end
    end
    false
  end

end
