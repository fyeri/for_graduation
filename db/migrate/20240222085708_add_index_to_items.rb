class AddIndexToItems < ActiveRecord::Migration[6.1]
  def change
    add_index :items, [:name, :character]
  end
end
