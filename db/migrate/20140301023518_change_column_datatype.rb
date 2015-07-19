class ChangeColumnDatatype < ActiveRecord::Migration
  def change
  	  change_column :users, :account, :string
  	  change_column :users, :phone, :string
  	  change_column :users, :fax, :string
  end
end
