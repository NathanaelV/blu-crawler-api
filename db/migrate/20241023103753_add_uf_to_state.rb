class AddUfToState < ActiveRecord::Migration[7.2]
  def change
    add_column :states, :uf, :string
    add_column :states, :slug, :string
  end
end
