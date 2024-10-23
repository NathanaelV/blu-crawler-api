class CreateCategorySuppliersTable < ActiveRecord::Migration[7.2]
  def change
    create_table :categories_suppliers do |t|
      t.belongs_to :category
      t.belongs_to :supplier
    end
  end
end
