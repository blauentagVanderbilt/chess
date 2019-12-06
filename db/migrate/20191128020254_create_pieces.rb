class CreatePieces < ActiveRecord::Migration[5.2]
  def change
    create_table :pieces do |t|
      t.integer :x_position
      t.integer :y_position
      t.string :type
      t.string :white?
      t.string :name
      t.integer :user_id
      t.integer :game_id
      t.datetime :created_at
      t.datetime :updated_at
      t.timestamps
    end
  end
end
