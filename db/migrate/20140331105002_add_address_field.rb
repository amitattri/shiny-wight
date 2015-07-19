class AddAddressField < ActiveRecord::Migration
  def change
    change_table :addresses do |t|
      t.rename :recipient_address, :rep_address_one
    end
    add_column :addresses, :rep_address_two, :string
  end
end
