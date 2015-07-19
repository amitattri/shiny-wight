class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :registerable
  #######################
  ## Constants
  #######################
  #######################
  ## Associations
  #######################
  has_many :shipments, dependent: :destroy
  has_many :addresses, dependent: :destroy
  #######################
  ## Attribute Accessors
  #######################
  #######################
  ## scopes
  #######################
  #######################
  ## Validations
  #######################
  validates :company_name, :usr_address, :city, :state, :zipcode, :phone, :first_name, :last_name, :email,:password,:service_type, :terms_of_use, presence: true
  #validates :account, uniqueness: true
  #######################
  ## Call Backs
  #######################
  before_create :set_unique_attributes
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
  def decrypted
    decrypted_pswd = AESCrypt.decrypt(self.encrypted, "X"*32)
    return "#{decrypted_pswd}"
  end

  def full_name
    return"#{self.first_name} #{self.last_name}"
  end

  def full_address
    return"#{self.first_name},#{self.usr_address},#{self.city},#{self.state},#{self.zipcode}"
  end
  #######################
  ## Protected Methods
  #######################
  protected
  #######################
  ## Private Methods
  #######################
  private

  def set_unique_attributes
    self.encrypted = AESCrypt.encrypt(self.encrypted, "X"*32)
    if !self.account_number.present?
      acc_tmp = nil
      while(acc_tmp.blank?)
        acc_tmp = rand(36**6).to_s(36).upcase
        acc_tmp = nil if User.find_by_account_number(acc_tmp)
      end
      self.account_number = acc_tmp
    end
  end
end
