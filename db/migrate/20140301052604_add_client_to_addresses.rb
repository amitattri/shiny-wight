class AddClientToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :client, :string
  end
end
