class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.string :character, null: false
      t.integer :category, null: false
      t.date :purchased_on
      t.string :image
      t.references :user, null:false, foregn_key: true

      t.timestamps
    end
  end
end
