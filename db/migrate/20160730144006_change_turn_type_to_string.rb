class ChangeTurnTypeToString < ActiveRecord::Migration[5.0]
  def change
    change_column :games, :turn, :string
  end
end
