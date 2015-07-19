require 'aws/s3'
class Shipment < ActiveRecord::Base
  include ExpectedDate
  #######################
  ## Constants
  #######################
  #######################
  ## Associations
  #######################
  belongs_to :user
  has_many :details, dependent: :destroy
  #######################
  ## Attribute Accessors
  #######################
  has_attached_file :signature, :styles => {:thumb=> "100x100>", :medium  => "300x300>"}
  #######################
  ## scopes
  #######################
  scope :admin_shipment_by_date, -> (from_time, to_time) { where("ship_date BETWEEN ? and ?",from_time,to_time) }
  scope :shipment_history, -> { where("expected_delivery_date <= ?", Date.today).order("created_at DESC") }
  scope :today_shipments,-> { where("ship_date = ?", Date.today) }
  scope :shipment_by_date, -> (user,from_time, to_time) { where("ship_date BETWEEN ? and ? and user_id = ?",from_time,to_time,user ) }
  scope :current_shipping, -> (user) { where("status != 'Delivered' and user_id = ?",user ).order("created_at DESC") }
  scope :manifest, ->(user) { where("expected_delivery_date = ? and user_id = ?", Date.today, user).order("created_at DESC") }
  #######################
  ## Validations
  #######################
  validates :tracking, presence: true
  validates :tracking, uniqueness: true
  validates_length_of :cod_val, :declared_val, :maximum => 6
  #######################
  ## Call Backs
  #######################
  before_create :check_cut_off_time, :set_web_services_attr
  #######################
  ## Class Methods
  #######################
  class << self
  end
  #######################
  ## Virtual Attributes
  #######################
  #######################
  ## Public Methods
  #######################
  def self.set_tracking
    value = SecureRandom.random_number(99999)
    Shipment.valid_attribute(:tracking,value)
  end

  def self.valid_attribute(attr, value)
    mock = self.new(attr => value)
    while mock.errors.has_key?(attr)
      nvalue = SecureRandom.random_number(99999)
      valid_attribute(attr, nvalue)
    end
    return value
  end
  protected
  #######################
  ## Protected Methods
  #######################
  private
  #######################
  ## Private Methods
  #######################
  def check_cut_off_time
    if Time.now.strftime("%I:%M%P") > Home.first.cut_off_time.strftime("%I:%M%P")
      self.expected_delivery_date = Date.today+1.days
    else
      self.expected_delivery_date = Date.today
    end
  end

  def set_web_services_attr
    user = User.find(self.user_id)
    self.user_name_print = user.full_name
    self.to_customer = self.user_id
    self.from_customer = self.client
    self.from_address = user.full_address
    client = Address.find(self.client)
    self.to_address = client.full_address
  end

end
