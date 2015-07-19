class AddSignatureType < ActiveRecord::Migration
  def change
    change_table :shipments do |t|
      t.rename :signature, :signature_status
    end
    drop_table :contacts
    create_table :contacts do |t|
      t.string :email
      t.string :name
      t.string :subject
      t.text :query
      t.attachment :signature
      t.timestamps
    end
  end
end
