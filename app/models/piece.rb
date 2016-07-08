class Piece < ActiveRecord::Base
  belongs_to :game
  belongs_to :player

  validates :type, inclusion: { in: %w(pawn rook bishop knight king queen) }
end
