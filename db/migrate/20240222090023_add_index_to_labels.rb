class AddIndexToLabels < ActiveRecord::Migration[6.1]
  def change
    add_index :labels, :name
  end
end
