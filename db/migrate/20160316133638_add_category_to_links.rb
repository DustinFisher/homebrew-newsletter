class AddCategoryToLinks < ActiveRecord::Migration
  def change
    add_reference :links, :category, index: true, foreign_key: true
  end
end
