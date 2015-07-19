class ChangeStatusDefaultValue < ActiveRecord::Migration
  def change
  	change_column :shipments, :status, :string, :default => "Awating Pickup"
  end
end
