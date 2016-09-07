class ChangeXyAgain < ActiveRecord::Migration[5.0]
  change_table :pieces do |t|
    t.rename :x, :x_position
    t.rename :y, :y_position
  end
end
