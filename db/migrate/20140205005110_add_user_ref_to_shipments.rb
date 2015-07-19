class AddUserRefToShipments < ActiveRecord::Migration
  def change
    add_reference :shipments, :user, index: true
  end
end
