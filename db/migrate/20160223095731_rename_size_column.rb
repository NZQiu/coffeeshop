class RenameSizeColumn < ActiveRecord::Migration
  def change
    rename_column :items, :size, :cup_size
  end
end
