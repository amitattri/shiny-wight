class AddFieldsToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.rename :name, :company_name
      t.rename :account, :service_type
      t.rename :address, :usr_address
    end
    add_column :users, :account_number, :string
    add_column :users, :encrypted, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :is_admin, :boolean, :default => false
    add_column :users, :terms_of_use, :boolean
  end
end
