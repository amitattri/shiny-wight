class AddFieldsToShipment < ActiveRecord::Migration
  def change
    add_column :shipments, :save_to_book, :boolean
    add_column :shipments, :instructions, :text
  end
end
