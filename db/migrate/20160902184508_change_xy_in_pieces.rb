class ChangeXyInPieces < ActiveRecord::Migration[5.0]
  change_table :pieces do |t|
    t.rename :x_position, :x
    t.rename :y_position, :y
  end
end
