class CreateLabels < ActiveRecord::Migration[6.1]
  def change
    create_table :labels do |t|
      t.string :name, null:false
      t.references :user, null:false, foregn_key: true

      t.timestamps
    end
  end
end
