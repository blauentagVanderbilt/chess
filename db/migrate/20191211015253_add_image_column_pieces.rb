class AddImageColumnPieces < ActiveRecord::Migration[5.2]
  def change
    add_column :pieces, :picture, :string
  end
end
