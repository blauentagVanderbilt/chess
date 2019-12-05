class CreateChessPieces < ActiveRecord::Migration[5.2]
  def change
    create_table :chess_pieces do |t|
      t.integer :color, null: false
      t.integer :x_pos, null: false
      t.integer :y_pos, null: false
      t.string :type, null: false
    end
  end
end
