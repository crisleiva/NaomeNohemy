class AddCityStateZipToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :city, :string
    add_column :orders, :state, :string
    add_column :orders, :zip_code, :integer
  end
end
