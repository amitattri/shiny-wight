class AddFieldsToShipmentModel < ActiveRecord::Migration
  def change
    change_table :shipments do |t|
      t.rename :packages, :number_of_packages
    end
    add_column :shipments, :pickup_at, :date
    add_column :shipments, :deliver_at, :date
    add_column :shipments, :picked_up_at, :date
    add_column :shipments, :delivered_at, :date
    add_column :shipments, :to_customer, :integer
    add_column :shipments, :from_customer, :integer
    add_column :shipments, :signature_file_name, :string
    add_column :shipments, :signature_content_type, :string
    add_column :shipments, :signature_updated_at, :date
    add_column :shipments, :signature_file_size, :integer
    add_column :shipments, :from_address, :string
    add_column :shipments, :to_address, :string
    add_column :shipments, :user_name_print, :string
  end
end
