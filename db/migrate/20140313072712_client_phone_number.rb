class ClientPhoneNumber < ActiveRecord::Migration
  def change
  	add_column :addresses, :phone, :string
    add_column :shipments, :cod_val, :integer
    add_column :shipments, :declared_val, :integer
  end
end
