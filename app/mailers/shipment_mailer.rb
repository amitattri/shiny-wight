class ShipmentMailer < ActionMailer::Base
  default from: "\"Aa Express Delivery Inc.\" <attriamit8@gmail.com>"

  def new_shipment(shipment)
  	@shipment = shipment
  	@user = User.find(@shipment.user)
  	mail(to: @user.email, subject: "New shipment placed on Aa Express.")
  end

  def updated_shipment(shipment)
    @shipment = shipment
    @user = User.find(@shipment.user)
    mail(to: @user.email, subject: "Shipment updated on Aa Express.")
  end

  def new_contact(contact)
  	@contact=contact
  	mail(to: "#{User.find_by_is_superadmin(true).email}", Subject: "New Contact us/feedback form filled/created")
  end

  def new_user_notification(user_id)
    @user = User.find(user_id)
    mail(to: @user.email, subject: "You have been placed on a waiting list for a Aa Express account.")
  end

  def account_ready_notification(user_id)
    @user = User.find(user_id)
    mail(to: @user.email, subject: "Welcome! Your Aa Express account is Ready now.")
  end
end
