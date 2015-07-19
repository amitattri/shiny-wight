class UserToSuperAdmin < ActiveRecord::Migration
  def change
    remove_column :shipments, :signature_file_name
    remove_column :shipments, :signature_content_type
    remove_column :shipments, :signature_updated_at
    remove_column :shipments, :signature_file_size
    add_column :users, :is_superadmin, :boolean, :default => false
    add_column :homes, :user_id, :integer
    add_column :homes, :admin_id, :integer
    change_table :shipments do |t|
      t.attachment :signature
    end
  end
end
