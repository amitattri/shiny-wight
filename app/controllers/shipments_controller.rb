require 'securerandom'
require 'pp'
class ShipmentsController < ApplicationController
  protect_from_forgery only: [:track]

  autocomplete :address, :client, :extra_data => [:id,:client,:rep_address_one,:city,
                                                  :state,:zipcode,:recipient,:phone,:rep_address_two]
  before_filter :authenticate_user!, :except => [:track, :pickup, :deliver]
  before_action :set_shipment, only: [:show, :edit, :update, :destroy]

  #landing page while user login
  def index
    @shipments = Shipment.current_shipping(current_user.id)

    if params[:shipment_from].present? && params[:shipment_to].present?
      shipment_from = params[:shipment_from].split("-")[2]+'-'+ params[:shipment_from].split("-")[0]+'-'+ params[:shipment_from].split("-")[1]
      shipment_to = params[:shipment_to].split("-")[2]+'-'+ params[:shipment_to].split("-")[0]+'-'+ params[:shipment_to].split("-")[1]
      @shipments = Shipment.shipment_by_date(current_user.id,shipment_from,shipment_to)
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
      @shipments = (current_user.shipments).find_by_tracking(params[:tracking_no])
      if params[:tracking_no].blank? && @shipments.nil?
        flash.now[:notice] = 'Please enter tracking number to track shipment.'
      elsif @shipments.nil?
        flash.now[:notice] = 'Shipment not found with this('+ params[:tracking_no] +') tracking number.'
      else
        flash.now[:message] = 'Shipment found.'
      end
    end

  end

  #reporting tab page
  def reporting
    @shipments = current_user.shipments.order("created_at DESC")

    if params[:shipment_from].present? && params[:shipment_to].present?
      shipment_from = params[:shipment_from].split("-")[2]+'-'+ params[:shipment_from].split("-")[0]+'-'+ params[:shipment_from].split("-")[1]
      shipment_to = params[:shipment_to].split("-")[2]+'-'+ params[:shipment_to].split("-")[0]+'-'+ params[:shipment_to].split("-")[1]
      @shipments = Shipment.shipment_by_date(current_user.id,shipment_from,shipment_to)
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
      @shipments = (current_user.shipments).find_by_tracking(params[:tracking_no])
      if params[:tracking_no].blank? && @shipments.nil?
        flash.now[:notice] = 'Please enter tracking number to track shipment.'
      elsif @shipments.nil?
        flash.now[:notice] = 'Shipment not found with this('+ params[:tracking_no] +') tracking number.'
      else
        flash.now[:message] = 'Shipment found.'
      end
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  #under reporting tag todays manifest
  def manifest
    @shipments = Shipment.manifest(current_user.id)
    respond_to do |format|
      format.html
      format.js
    end
  end

  #under reporting tag address_listing
  def address_listing
    @addresses = current_user.addresses
  end

  #tracking tag for searching shipment
  def tracking
    @shipments = current_user.shipments.order("created_at DESC")
    #Searching Shipment between selected dates
    if params[:shipment_from].present? && params[:shipment_to].present?
      shipment_from = params[:shipment_from].split("-")[2]+'-'+ params[:shipment_from].split("-")[0]+'-'+ params[:shipment_from].split("-")[1]
      shipment_to = params[:shipment_to].split("-")[2]+'-'+ params[:shipment_to].split("-")[0]+'-'+ params[:shipment_to].split("-")[1]
      @shipments = Shipment.shipment_by_date(current_user.id,shipment_from,shipment_to)
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
      @shipments = (current_user.shipments).find_by_tracking(params[:tracking_no])
      if params[:tracking_no].blank? && @shipments.nil?
        flash.now[:notice] = 'Please enter tracking number to track shipment.'
      elsif @shipments.nil?
        flash.now[:notice] = 'Shipment not found with this('+ params[:tracking_no] +') tracking number.'
      else
        flash.now[:message] = 'Shipment found.'
      end
    end
  end

  #print shipment label page
  def show
    @client=Address.find(@shipment.client)
    respond_to do |format|
      format.html { render action: 'show',:layout => false}
    end
  end

  def print_by_date
    if params['shipment'] =='1'
      @print_shipment = true
    elsif params['tracking'] =='1'
      @print_tracking = true
    elsif params['reporting'] =='1'
      @print_reporting = true
    elsif params['su_print'] =='1'
      @su_print = true
    end
  end

  #For printing of different pages
  def print_pages
    if params['shipment'] =='1'
      if params[:shipment_from].present? && params[:shipment_to].present?
        shipment_from = params[:shipment_from].split("-")[2]+'-'+ params[:shipment_from].split("-")[0]+'-'+ params[:shipment_from].split("-")[1]
        shipment_to = params[:shipment_to].split("-")[2]+'-'+ params[:shipment_to].split("-")[0]+'-'+ params[:shipment_to].split("-")[1]
        @shipments = Shipment.shipment_by_date(current_user.id,shipment_from,shipment_to)
      end
      @print_shipment = true
    elsif params['tracking'] =='1'
      @shipments = current_user.shipments.order("created_at DESC")
      @print_tracking = true
    elsif params['reporting'] =='1'
      if params[:shipment_from].present? && params[:shipment_to].present?
        shipment_from = params[:shipment_from].split("-")[2]+'-'+ params[:shipment_from].split("-")[0]+'-'+ params[:shipment_from].split("-")[1]
        shipment_to = params[:shipment_to].split("-")[2]+'-'+ params[:shipment_to].split("-")[0]+'-'+ params[:shipment_to].split("-")[1]
        @shipments = Shipment.shipment_by_date(current_user.id,shipment_from,shipment_to)
      end
      @print_reporting = true
    elsif params['address'] =='1'
      @addresses = current_user.addresses
      @print_addresses = true
    end
    render "shipments/print_shipment", :layout => false
  end

  #when user wants to create new shipment
  def new
    @shipment = Shipment.new(:tmx => current_user.service_type, :signature_status => 'Required')
    #AutoComplete for Client Name
    @address_autofill = Address.new
  end

  #for editing the shipment details
  def edit
    #@packages= @shipment.details
    @address = Address.find(@shipment.client)
    $page = nil
    $page = params[:pg] if params[:pg].present?
  end

  #for creating the new shipment
  def create
    @shipment = current_user.shipments.build(shipment_params_one)
      #Generating Tracking Number for Shipment
      @shipment.tracking = Shipment.set_tracking
      @shipment.tmx = current_user.service_type

      #Saving Address
        if @shipment.save_to_book
          @address = Address.save_address(current_user,params[:address].permit!)
        else
          if params[:client][:id].present?
            @address = Address.find(params[:client][:id])
          else
            @address = Address.save_address(current_user,params[:address].permit!)
          end
        end
      @shipment.client = @address.id
    respond_to do |format|
      if @shipment.save
        #Set Packages Detail
        #Detail.set_pakages(@shipment,params[:packages_detail]) if @shipment.packages?

        #Sending mail for new shipment to user
        ShipmentMailer.new_shipment(@shipment).deliver if @shipment.notification
        format.html { redirect_to @shipment}
        format.json { render action: 'show', status: :created, location: @shipment }

      else
        format.html { render action: 'new' }
        format.json { render json: @shipment.errors, status: :unprocessable_entity }
      end
    end
  end

  #for updation of the existing shipment
  def update
    @shipment.tmx = current_user.service_type
    if @shipment.update(shipment_params_one)
      #Update Packages Detail
      #Detail.update_pakages(@shipment,params[:packages_detail]) if @shipment.packages?
      #Sending mail for Updation of shipment to user
      ShipmentMailer.updated_shipment(@shipment).deliver if @shipment.notification && !current_user.is_admin?
      respond_to do |format|
        format.html {
          redirect_to @shipment
        }
        format.json { render action: 'show', status: :created, location: @shipment }
      end
    else
      flash.now[:notice] = 'Shipment was Not Updated.'
      render action: 'edit'
    end
  end

  # this method is used for web services module
  def track
    @shipment = Shipment.where(:tracking => params[:id]).select("tracking, status, from_address, to_address, number_of_packages, picked_up_at, delivered_at").first #false as more_shipments,
    respond_to do |format|
      format.json { render json: @shipment, :except => [:id]}
    end
  end

  # this method is also used for web services module
  def pickup
    @shipment = Shipment.where(:tracking => params[:id]).first
    @shipment.picked_up_at = Time.now
    @shipment.status = "Picked Up"
    @shipment.number_of_packages = params[:number_of_packages] || 1

    respond_to do |format|
      if @shipment.save
        format.json { render json: {tracking: @shipment.tracking, status: @shipment.status, success: true}.to_json }
      else
        format.json { render json: @shipment.errors,
                      status: :unprocessable_entity,
                      tracking: @shipment.tracking,
                      success: false }
      end
    end
  end

  # this method is also used for web services module
  def deliver
    @shipment = Shipment.where(:tracking => params[:id]).first
    @shipment.delivered_at = Time.now
    @shipment.status = "Delivered"
    @shipment.signature = params[:signature]
    @shipment.user_name_print = params[:user_name_print]

    respond_to do |format|
      if @shipment.save
        format.json { render json: {tracking: @shipment.tracking, status: @shipment.status, success: true}.to_json }
      else
        format.json { render json: @shipment.errors,
                      status: :unprocessable_entity,
                      tracking: @shipment.tracking,
                      success: false }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shipment
      begin
        @shipment = Shipment.find_by_tracking(params[:id]) || @shipment = Shipment.find(params[:id])
      rescue
        if !@shipment.present?
          redirect_to root_path, :flash => {:notice => "Sorry, shipment not found in records."}
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shipment_params
      params.require(:shipment).permit(:tracking, :pickup_at, :deliver_at, :picked_up_at, :delivered_at, :signature_status, :number_of_packages, :from_address, :to_address)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shipment_params_one
      params.require(:shipment).permit!
    end
end
