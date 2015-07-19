class RegistrationsController < Devise::RegistrationsController

  #Home page open an account or user create
  def create
    params[:user][:encrypted] = request.parameters[:user][:password]
    resource = User.new(user_params)
    if resource.save
      ShipmentMailer.new_user_notification(resource).deliver
      respond_to do |format|
        format.html {
          flash[:message] = 'Thank you for choosing Aa Express.Please check your mail for further processing.'
          redirect_to root_path }
      end
    else
      usr_found = User.find_by_email(params[:user][:email])
      build_resource
      clean_up_passwords(resource)
      flash.now[:notice] = "There was some problem while creating user. Please make sure you have entered correct email and password."
      flash.now[:notice] = "There was some problem while creating user. User already exist by email you enterd, please provide another email." if usr_found.present?
      render :new
    end
  end

  #Admin user can only edit user's account
  def edit
    if current_user && (current_user.is_admin? || current_user.is_superadmin?)
      @resource = User.find_by_account_number(params[:id])
      @decrypted = @resource.decrypted
    else
      redirect_to root_path, :flash => {:notice => "You are not authorized user to access that page."}
    end
  end

  #Admin user can only update user's account
  def update
    if current_user && (current_user.is_admin? || current_user.is_superadmin?)
      @user = User.find_by_account_number(params[:id])
      @user.update(params[:user].permit(:first_name, :last_name, :password, :service_type, :email, :company_name,:usr_address,:phone,:fax,:terms_of_use, :city, :state, :zipcode))
      if @user.acc_ready_mail == false
        @user.update_columns(:acc_ready_mail => true)
        ShipmentMailer.account_ready_notification(@user.id).deliver
      end
      redirect_to admin_index_path, :flash => {:notice => "User has been succesfully updated and activated."}
    else
      redirect_to root_path, :flash => {:notice => "You are not authorized user to access that page."}
    end
  end

  private
  #Create user attributes permitting!
  def user_params
    params.require(:user).permit(:first_name,:encrypted, :city, :state, :zipcode, :last_name, :phone, :fax, :usr_address, :terms_of_use, :company_name,:service_type, :email, :password, :salt, :encrypted_password)

  end

end
