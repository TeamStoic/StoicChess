class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|

      t.string :color
      t.string :type

      t.integer :x_position
      t.integer :y_position
      t.integer :game_id
      t.integer :player_id

      t.boolean :captured
      t.boolean :checkmate

      t.timestamps
    end
  end
end
