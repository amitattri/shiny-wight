class AddFiledsOfAdminAction < ActiveRecord::Migration
  def change
    add_column :homes, :cut_off_time, :time
    add_column :users, :is_active, :boolean, :default => true
    add_column :users, :sudo_flag, :boolean, :default => false
  end
end
