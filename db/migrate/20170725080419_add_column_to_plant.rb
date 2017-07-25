class AddColumnToPlant < ActiveRecord::Migration[5.1]
  def change
    add_column :plants, :name, :string
    add_column :plants, :height, :int, default: 1
    add_column :plants, :water, :int, default: 0
  end
end
