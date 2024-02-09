class CreateItemLabels < ActiveRecord::Migration[6.1]
  def change
    create_table :item_labels do |t|
      t.references :item, null: false, foreign_key: true
      t.references :label, null: false, foreign_key: true
      t.string :reason

      t.timestamps
    end
  end
end
