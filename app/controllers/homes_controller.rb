class HomesController < ApplicationController

  #Application landing page
  def index
    if(params[:tracking_no])
      @status=get_status
      if @status.blank?
        flash.now[:notice] = 'Shipment not found by this number. Please make sure you have entered correct tracking number.'
      else
        flash.now[:message] = "Shipment found, your shipment status is:- #{@status}"
      end
    end
  end

  #Contect us page of application
  def new_contact
    @contact=Contact.new()
  end

  #Contect us page of application
  def check_paperclip
    if request.post?
      @contact = Contact.new(check_sign_params)
      if @contact.save
        render action: 'check_paperclip', notice: 'contact created!'
        #redirect_to action: 'index', notice: 'User was successfully created.'
      else
        render action: 'check_paperclip', alert: 'contact could not be created'
      end
    else
      @contact=Contact.new()
    end
  end

  #Contect us mail shut
  def save_contact
    @contact=(params[:contact])
    ShipmentMailer.new_contact(@contact).deliver
  end

  #About us page of application
  def about_us
  end

  #Terms of Use page of application
  def terms_of_use
  end

  private
  #Home page tracking shipment by number
  def get_status
    shipment= Shipment.find_by_tracking(params[:tracking_no])
    shipment.status if shipment
  end

  def check_sign_params
      params.require(:contact).permit(:name, :email, :subject, :query, :signature)
  end
end
