class Piece < ActiveRecord::Base
  attr_accessor :type, :color

  belongs_to :game
  belongs_to :player

  validates :type, inclusion: { in: %w(pawn rook bishop knight king queen) }
  validates :color, inclusion: { in: %w(black white) }
end
