class RemoveUrlFromSupplier < ActiveRecord::Migration[7.2]
  def change
    remove_column :suppliers, :url, :string
  end
end
