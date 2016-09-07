FactoryGirl.define do
  factory :pawn do
    trait :white do
      color 'white'
      x_position 5
      y_position 6
    end
    trait :black do
      color 'black'
      x_position 5
      y_position 1
    end
    trait :moved do
      y_position 5
      moved true
    end
  end
end
