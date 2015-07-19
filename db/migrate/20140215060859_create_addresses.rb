class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :user_id
      t.string :recipient
      t.string :recipient_address
      t.string :city
      t.string :state
      t.string :zipcode

      t.timestamps
    end
  end
end
