class AddFieldToUsers < ActiveRecord::Migration
  def change
    add_column :users, :address, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :zipcode, :integer
    add_column :users, :account, :integer
    add_column :users, :phone, :integer
    add_column :users, :fax, :integer
  end
end
