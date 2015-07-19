# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts '***********************************************'
puts 'Creating Super Admin User account.'
user = User.find_or_create_by_email(:first_name => "Admin", :last_name => "User", :is_admin => 1, :company_name => 'AA Express Delivery LLC', :email => "admin@aaexpress.com",
 :service_type =>'Gold', :terms_of_use => 1, :password => "aaexpress", :encrypted => "aaexpress",
 :city => "Glendale", :state => "CA", :zipcode => 91203, :phone => "818-649-1050", :fax => "818-484-3007", :usr_address => "417 W. Arden ave Unit 114c")
user = User.first
if user.present?
  user.update_columns(:is_superadmin => true, :is_admin => false)
  puts '-----------------------------------------------'
  puts 'Super Admin User account created successfully!'
  puts 'Super Admin user email for login: ' << user.email
  puts '-----------------------------------------------'
else
  puts '*************ERROR****************'
  puts 'Super Admin User account Not created successfully!'
  puts '******Please first create user by Open an Account link at home, after that run this command******'
end
puts 'now set cut off time for shipment.'
cut_off_time = Home.find_or_create_by_cut_off_time :cut_off_time => "3:00PM"
puts 'Cut off time set successfully, now for 3:00 PM'
puts '***********************************************'
