class Address < ActiveRecord::Base
  #######################
  ## Constants
  #######################
  #######################
  ## Associations
  #######################
  belongs_to :user
  #######################
  ## Attribute Accessors
  #######################
  #######################
  ## scopes
  #######################
  #######################
  ## Validations
  #######################
  #######################
  ## Call Backs
  #######################
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
  def full_address
    return"#{self.client},#{self.rep_address_one} #{self.rep_address_two},#{self.city},#{self.state},#{self.zipcode}"
  end

  def self.save_address(user,address)
    obj_address=user.addresses.build(address)
    obj_address.save
    obj_address
  end
  #######################
  ## Protected Methods
  #######################
  protected
  #######################
  ## Private Methods
  #######################
  private
end
