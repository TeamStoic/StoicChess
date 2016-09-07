# Game object that handles turn logic and board creation.
class Game < ActiveRecord::Base
  has_many :pieces, dependent: :destroy
  has_many :players, dependent: :destroy
  has_many :users, through: :players
  after_create :populate!

  def populate!
    populate_players!
    populate_pieces!
  end

  def generate_tiles
    tiles = []
    (0..7).each do |x|
      (0..7).each do |y|
        tiles << [x, y]
      end
    end
    tiles
  end

  def next_turn
    if current_player.enemy.king.in_check?
      current_player.enemy.king.in_checkmate? ? game_over! : check!
    end
    incremented_turn = turn + 1
    update(turn: incremented_turn)
  end

  def game_over!
    update(active: false)
  end

  def check!
  end

  def current_player
    turn.odd? ? white : black
  end

  def white
    players.find_by(color: 'white')
  end

  def black
    players.find_by(color: 'black')
  end

  # Returns the piece occupying the coordinates.
  def tile_occupant(x, y)
    pieces.find_by(x_position: x, y_position: y)
  end

  def tile_occupied?(x, y)
    pieces.exists?(x_position: x, y_position: y)
  end

  private

  def populate_pieces!
    populate_pawns!
    populate_knights!
    populate_bishops!
    populate_rooks!
    populate_queens!
    populate_kings!
  end

  def populate_players!
    players.create(color: 'white')
    players.create(color: 'black')
  end

  def populate_pawns!
    (0..7).each do |i|
      create_piece('Pawn', 'white', i, 6)
    end
    (0..7).each do |i|
      create_piece('Pawn', 'black', i, 1)
    end
  end

  def populate_knights!
    create_piece('Knight', 'white', 1, 7)
    create_piece('Knight', 'white', 6, 7)
    create_piece('Knight', 'black', 1, 0)
    create_piece('Knight', 'black', 6, 0)
  end

  def populate_bishops!
    create_piece('Bishop', 'white', 2, 7)
    create_piece('Bishop', 'white', 5, 7)
    create_piece('Bishop', 'black', 2, 0)
    create_piece('Bishop', 'black', 5, 0)
  end

  def populate_rooks!
    create_piece('Rook', 'white', 0, 7)
    create_piece('Rook', 'white', 7, 7)
    create_piece('Rook', 'black', 0, 0)
    create_piece('Rook', 'black', 7, 0)
  end

  def populate_queens!
    create_piece('Queen', 'white', 3, 7)
    create_piece('Queen', 'black', 3, 0)
  end

  def populate_kings!
    create_piece('King', 'white', 4, 7)
    create_piece('King', 'black', 4, 0)
  end

  def create_piece(type, color, x, y)
    if color == 'white'
      white.pieces.create(type: type, x_position: x, y_position: y,
                          color: 'white', game_id: id)
    else
      black.pieces.create(type: type, x_position: x, y_position: y,
                          color: 'black', game_id: id)
    end
  end
end
