class AddCounterToPieces < ActiveRecord::Migration[5.2]
  def change
    add_column :pieces, :move_number, :integer, :default => 0
  end
end
