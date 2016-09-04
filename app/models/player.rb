# player Model
class Player < ApplicationRecord
  has_many :pieces
  belongs_to :game
  belongs_to :user

  validates :color, inclusion: { in: %w(black white) }

  def enemy
    color == 'white' ? game.black : game.white
  end

  def enemy_pieces
    enemy.pieces.select { |piece| piece.captured != true }
  end

  def king
    piece_lookup('King')
  end

  def queen
    piece_lookup('Queen')
  end

  def rooks
    pieces_lookup('Rook')
  end

  def bishops
    pieces_lookup('Bishop')
  end

  def knights
    pieces_lookup('Knight')
  end

  def pawns
    pieces_lookup('Pawn')
  end

  private

  def piece_lookup(type)
    pieces.find_by(type: type)
  end

  def pieces_lookup(type)
    pieces.where(type: type)
  end
end
