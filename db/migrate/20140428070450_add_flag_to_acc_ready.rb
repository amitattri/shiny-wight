class AddFlagToAccReady < ActiveRecord::Migration
  def change
    add_column :users, :acc_ready_mail, :boolean, :default => false
  end
end
