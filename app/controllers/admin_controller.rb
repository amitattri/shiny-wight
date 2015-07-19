class AdminController < ApplicationController

  # before access any method check Admin User?
  before_filter :admin_required!, :except => :back_to_account

  #Admin user landing page
  def index
    @users = User.all
  end

  #Admin user can see shipment history
  def shipment_history
    @shipments = Shipment.shipment_history

    if params[:shipment_from].present? && params[:shipment_to].present?
      shipment_from = params[:shipment_from].split("-")[2]+'-'+ params[:shipment_from].split("-")[0]+'-'+ params[:shipment_from].split("-")[1]
      shipment_to = params[:shipment_to].split("-")[2]+'-'+ params[:shipment_to].split("-")[0]+'-'+ params[:shipment_to].split("-")[1]
      @shipments = Shipment.admin_shipment_by_date(shipment_from,shipment_to)
      if @shipments.empty?
        flash.now[:notice] = 'Shipment(s) not found between '+ params[:shipment_from]+' to '+ params[:shipment_to]+' dates.'
      else
        flash.now[:message] = 'Shipment(s) found.'
      end
    #else
    #  flash.now[:notice] = 'Please pick date from and date to of shipments to track.'
    end

    #Searching Shipment by Tracking No.
    if(params[:tracking_no])
      @shipments = Shipment.find_by_tracking(params[:tracking_no])
      if params[:tracking_no].blank? && @shipments.nil?
        flash.now[:notice] = 'Please enter tracking number to track shipment.'
      elsif @shipments.nil?
        flash.now[:notice] = 'Shipment not found with this('+ params[:tracking_no] +') tracking number.'
      else
        flash.now[:message] = 'Shipment found.'
      end
    end
  end

  #method for calling pop-up model box of date-picker
  def new_release
    @requested_user = User.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  #Admin can add note for any user account
  def add_note_to_user
    @requested_user = User.find(params[:id])
    if request.post? || request.put?
      @requested_user.update_columns(:usr_note => params[:usr_note])
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  #Admin can see all past date shipments and can print
  def user_shipment_history
    @sp_fm = params[:shipment_from]
    @sp_to = params[:shipment_to]
    @id = params[:id]
    if params[:shipment_from].present? && params[:shipment_to].present?
      shipment_from = params[:shipment_from].split("-")[2]+'-'+ params[:shipment_from].split("-")[0]+'-'+ params[:shipment_from].split("-")[1]
      shipment_to = params[:shipment_to].split("-")[2]+'-'+ params[:shipment_to].split("-")[0]+'-'+ params[:shipment_to].split("-")[1]
      @shipments = Shipment.shipment_by_date(params[:id],shipment_from,shipment_to)
      #@shipments = Shipment.shipment_by_date(params[:id],params[:shipment_from], params[:shipment_to])
      if @shipments.empty?
        flash.now[:notice] = 'Shipment(s) not found between '+ params[:shipment_from]+' to '+ params[:shipment_to]+' dates.'
      else
        flash.now[:message] = 'Shipment(s) found.'
      end
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  #Admin can see all present date shipments
  def today_shipments
    @shipments = Shipment.today_shipments
  end

  def print_pages_history
    if params['su_print'] =='1' and (current_user.is_admin? || current_user.is_superadmin?)
      if params[:shipment_from].present? && params[:shipment_to].present?
        shipment_from = params[:shipment_from].split("-")[2]+'-'+ params[:shipment_from].split("-")[0]+'-'+ params[:shipment_from].split("-")[1]
        shipment_to = params[:shipment_to].split("-")[2]+'-'+ params[:shipment_to].split("-")[0]+'-'+ params[:shipment_to].split("-")[1]
        @shipments = Shipment.admin_shipment_by_date(shipment_from,shipment_to)
      end
      @su_print = true
    end
    render :layout => false
  end

  #Admin can see shipments signature
  def show_signature
    @shipment = Shipment.find(params[:id])

    #respond_to do |format|
    #  format.html
    #  format.js
    #end
    render :layout => false
  end

  #Admin can manage misc. parameters
  def action_by_admin
    @current_time = Home.last_cut_off_time.first
  end

  #SuperAdmin can make anyone Admin
  def make_user_admin
    @requested_user = User.find(params[:id])
    if @requested_user.present?
      if @requested_user.is_admin?
        @requested_user.update_columns(:is_admin => false)
        redirect_to admin_index_path, :flash => {:notice => "Requested user(#{@requested_user.first_name} #{@requested_user.last_name}) account successfully degraded from admin."}
      else
        @requested_user.update_columns(:is_admin => true)
        redirect_to admin_index_path, :flash => {:notice => "Requested user(#{@requested_user.first_name} #{@requested_user.last_name}) account successfully upgraded as admin."}
      end
    else
      redirect_to admin_index_path, :flash => {:notice => "Requested user not found."}
    end
  end

  #Admin can set cut off time of shipment
  def set_cut_off_time
    if params[:cut_off_time].present?
      #Home.all.each {|r| r.destroy}
      Home.create(:cut_off_time => params[:cut_off_time])
      redirect_to admin_action_by_admin_path, :flash => {:notice => "Shipment cut off time updated succesfully"}
    else
      flash.now[:notice] = 'please enter vaild time to procced.'
    end
  end

  #Admin user can activate or de-activate user
  def user_onoff_flag
    @requested_user = User.find_by_account_number(params[:id])
    if @requested_user.is_active?
      @requested_user.update_columns(:is_active => false)
      redirect_to admin_index_path, :flash => {:notice => "Requested user(#{@requested_user.first_name} #{@requested_user.last_name}) account successfully de-activated."}
    else
      @requested_user.update_columns(:is_active => true)
      redirect_to admin_index_path, :flash => {:notice => "Requested user(#{@requested_user.first_name} #{@requested_user.last_name}) account successfully activated."}
    end
  end

  #Admin can login as a normal user of anyone
  def login_as_user
    @requested_user = User.find_by_account_number(params[:id])
    Home.create(:admin_id => current_user.id, :user_id => @requested_user.id)
    sign_out(current_user)
    @requested_user.update_columns(:sudo_flag => true)
    sign_in(@requested_user)
    redirect_to shipments_path, :flash => {:notice => "Admin user signed in successfully as (#{@requested_user.first_name} #{@requested_user.last_name}) user account."}
  end

  #Admin now back to his account from normal user
  def back_to_account
    if request.post?
      encrypted_password = AESCrypt.encrypt(params[:admin_password], "X"*32)
      user_last_entry = Home.match_user(current_user.id).first
      got_admin = User.find(user_last_entry.admin_id)
      user_last_entry.destroy
      if got_admin.encrypted == encrypted_password
        usr_name = "#{current_user.first_name} #{current_user.last_name}"
        User.where(:sudo_flag => true).each {|usr| usr.update_columns(:sudo_flag => false)}
        sign_out(current_user)
        sign_in(got_admin)
        redirect_to admin_index_path, :flash => {:notice => "Admin user signed out successfully from (#{usr_name}) user account."}
      else
        current_user.update_columns(:sudo_flag => false)
        redirect_to root_path, :flash => {:notice => "Sorry, you are not an authorized person for access admin account."}
      end
    else
      respond_to do |format|
        format.js
      end
    end
  end

  private

end
