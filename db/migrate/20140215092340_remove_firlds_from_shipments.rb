class RemoveFirldsFromShipments < ActiveRecord::Migration
  def change
    remove_column :shipments, :city, :string
    remove_column :shipments, :state, :string
    remove_column :shipments, :zipcode, :integer
    remove_column :shipments, :recipient, :string
    remove_column :shipments, :address, :string
  end
end
