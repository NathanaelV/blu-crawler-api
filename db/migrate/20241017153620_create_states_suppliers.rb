class CreateStatesSuppliers < ActiveRecord::Migration[7.2]
  def change
    create_table :states_suppliers, id: false do |t|
      t.references :supplier, null: false, foreign_key: true
      t.references :state, null: false, foreign_key: true
    end
  end
end
