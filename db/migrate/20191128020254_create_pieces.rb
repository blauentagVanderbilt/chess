class CreatePieces < ActiveRecord::Migration[5.2]
  def change
    create_table :pieces do |t|
      t.integer :x_position
      t.integer :y_position
      t.string :type
      t.integer :color
      t.integer :player_id
      t.integer :game_id
      t.datetime :created_at
      t.datetime :updated_at
      t.timestamps
    end
    drop_table :chess_pieces
  end
end
