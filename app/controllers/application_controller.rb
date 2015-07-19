class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :check_user_account!

  #after sign in method to redirect user
  def after_sign_in_path_for(resource)
    if resource.is_admin? || resource.is_superadmin?
      admin_index_path
    else
      shipments_path
    end
  end

  #check for admin user.
  def admin_required!
    if current_user.blank?
      redirect_to new_user_session_path, :flash => {:notice => "Please login to access that page."}
    elsif !current_user.is_superadmin? && !current_user.is_admin?
      redirect_to root_path, :flash => {:notice => "You are not authorized user to access that page."}
    end
  end

  private
  #Action to check that User account is approved by TMX Staff.
  def check_user_account!
    if(current_user.present? && (current_user.service_type == 'pending' || !current_user.is_active?))
      service_type = current_user.service_type
      sign_out(current_user)
      redirect_to root_path, :flash => {:notice => "Your account is in waiting list for approval by Aa Express Staff.You will be notified when your account is ready."} and return if service_type == 'pending'
      redirect_to root_path, :flash => {:notice => "Your account is de-activated by Aa Express Staff, please contact to Aa Express Staff for account activation."}
    end
  end
end
