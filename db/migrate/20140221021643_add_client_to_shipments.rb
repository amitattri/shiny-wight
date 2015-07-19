class AddClientToShipments < ActiveRecord::Migration
  def change
    add_column :shipments, :client, :integer
  end
end
