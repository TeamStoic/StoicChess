# model Game,piece creation inside
# DO NOT chnage the sequence of methods
# or you will break the front end view
class Game < ActiveRecord::Base
  has_many :pieces
  has_many :players
  has_many :users, through: :players
  after_save :create_players!

  def populate!
    first_turn!
    populate_left_black_half!
    populate_right_black_half!
    populate_black_pawns!
    populate_white_pawns!
    populate_left_white_half!
    populate_right_white_half!
  end

  def end_turn!
    increment!(:turn)
  end

  def check?(color)
    king = king(color)
    enemy_pcs(color).each do |p|
      return true if p.valid_move?(king.x_position, king.y_position)
    end
    false
  end

  def white
    players.find_by(color: 'white')
  end

  def black
    players.find_by(color: 'black')
  end

  private

  def king(color)
    pieces.find_by(type: 'King', color: color)
  end

  def enemy_pcs(color)
    pieces.select { |p| p.color != color }
  end

  def create_players!
    players.create(color: 'white')
    players.create(color: 'black')
  end\

  def populate_left_black_half!
    create_piece('Rook', 'black', 0, 0)
    create_piece('Knight', 'black', 1, 0)
    create_piece('Bishop', 'black', 2, 0)
    create_piece('Queen', 'black', 3, 0)
  end

  def populate_right_black_half!
    create_piece('King', 'black', 4, 0)
    create_piece('Bishop', 'black', 5, 0)
    create_piece('Knight', 'black', 6, 0)
    create_piece('Rook', 'black', 7, 0)
  end

  def populate_black_pawns!
    (0..7).each do |i|
      create_piece('Pawn', 'black', i, 1)
    end
  end

  def populate_white_pawns!
    (0..7).each do |i|
      create_piece('Pawn', 'white', i, 6)
    end
  end

  def populate_left_white_half!
    create_piece('Rook', 'white', 0, 7)
    create_piece('Knight', 'white', 1, 7)
    create_piece('Bishop', 'white', 2, 7)
    create_piece('Queen', 'white', 3, 7)
  end

  def populate_right_white_half!
    create_piece('King', 'white', 4, 7)
    create_piece('Bishop', 'white', 5, 7)
    create_piece('Knight', 'white', 6, 7)
    create_piece('Rook', 'white', 7, 7)
  end

  def create_piece(type, color, x_pos, y_pos)
    if color == 'white'
      white.pieces.create(type: type, x_position: x_pos, y_position: y_pos,
                          color: 'white', game_id: id)
    else
      black.pieces.create(type: type, x_position: x_pos, y_position: y_pos,
                          color: 'black', game_id: id)
    end
  end

  def first_turn!
    update(turn: 1)
  end
end
