class ChangeColumnNameCategory < ActiveRecord::Migration[5.0]
def self.up
    rename_column :categories, :category, :label
  end
  def self.down
    rename_column :categories, :label, :category
  end
end
