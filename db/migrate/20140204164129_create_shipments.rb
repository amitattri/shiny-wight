class CreateShipments < ActiveRecord::Migration
  def change
    create_table :shipments do |t|
      t.string :company
      t.string :address
      t.string :city
      t.string :state
      t.integer :zipcode
      t.string :recipient
      t.string :tmx
      t.string :signature
      t.string :refrence
      t.integer :packages
      t.boolean :notification
      t.integer :tracking
      t.date :shipDate
      t.date :expectedDeliveryDate

      t.timestamps
    end
  end
end
