class PasswordsController < Devise::PasswordsController

  # POST /resource/password
  #forgot password
  def create
    user = User.find_by_email(params[:user][:email]) unless params[:user][:email].blank?
    if !user.blank?
      if !user.is_active?
        flash[:notice] =  "Your account is de-activated by Aa Express Staff, please contact to TM Express Staff for account activation."
        return redirect_to root_path
      elsif user.is_admin?
        flash[:notice] =  "You cannot reset admin password."
        return redirect_to root_path
      elsif user.service_type == 'pending'
        flash[:notice] =  "Your account is in waiting list for approval by Aa Express Staff.You will be notified when your account is ready."
        return redirect_to root_path
      end
    end

    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      respond_with({}, location: after_sending_reset_password_instructions_path_for(resource_name))
    else
      respond_with(resource)
    end

  end
end
