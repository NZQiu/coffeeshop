class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :drink_id
      t.integer :price
      t.string :size

      t.timestamps
    end
  end
end
