class CreateOwnedItems < ActiveRecord::Migration[6.1]
  def change
    create_table :owned_items do |t|
      t.integer :quantity, null:false
      t.text :remark
      t.references :item, null:false, foregn_key: true

      t.timestamps
    end
  end
end
