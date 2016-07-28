FactoryGirl.define do
  factory :game do
  end

  factory :empty_chess_board, class: Game do
    # after rails 5 you need to set up call_back first
    after(:build) do |game|
      game.class.set_callback(:create, :after,
                              :populate_left_black_half!,\
                              :populate_right_black_half!,\
                              :populate_black_pawns!,\
                              :populate_white_pawns!,\
                              :populate_left_white_half!,\
                              :populate_right_white_half!)
    end

    # After game is created, skip populate game pieces
    after(:build) do |game|
      game.class.skip_callback(:create, :after,
                               :populate_left_black_half!,\
                               :populate_right_black_half!,\
                               :populate_black_pawns!,\
                               :populate_white_pawns!,\
                               :populate_left_white_half!,\
                               :populate_right_white_half!)
    end
  end
end
