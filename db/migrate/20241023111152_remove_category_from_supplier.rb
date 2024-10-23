class RemoveCategoryFromSupplier < ActiveRecord::Migration[7.2]
  def change
    remove_reference :suppliers, :category, null: false, foreign_key: true
  end
end
