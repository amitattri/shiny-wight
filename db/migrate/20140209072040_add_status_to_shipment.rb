class AddStatusToShipment < ActiveRecord::Migration
  def change
    add_column :shipments, :status, :string, :default => "New"
  end
end
