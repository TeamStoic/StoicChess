FactoryGirl.define do
  factory :rook do
    trait :white do
      color 'white'
    end
    trait :black do
      color 'black'
    end
    trait :moved do
      moved true
      x_position 3
      y_position 3
    end
    game
  end
end
