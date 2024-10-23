class AddCnpjToSupplier < ActiveRecord::Migration[7.2]
  def change
    add_column :suppliers, :cnpj, :string
    add_column :suppliers, :slug, :string
  end
end
