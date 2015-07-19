class RemoveCompanyFromShipments < ActiveRecord::Migration
  def change
    remove_column :shipments, :company, :string
  end
end
