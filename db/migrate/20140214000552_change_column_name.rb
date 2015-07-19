class ChangeColumnName < ActiveRecord::Migration
  def change
  	change_table :shipments do |t|
  		t.rename :shipDate, :ship_date
  		t.rename :expectedDeliveryDate, :expected_delivery_date
  	end
  end
end
