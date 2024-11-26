class ChangeColumnCategoryToLists < ActiveRecord::Migration[7.1]
  def change
    remove_column :lists, :category
    add_column :lists, :category, :integer, default: 0
  end
end
