class Detail < ActiveRecord::Base
  #######################
  ## Constants
  #######################
  #######################
  ## Associations
  #######################
  belongs_to :shipment
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
  def self.set_pakages(shipment,pdetails)
    pdetails.each do |p|
      detail=shipment.details.build(p[1])
      detail.save
    end
  end

  def self.update_pakages(shipment,pdetails)
    pdetails.each do |p|
      package = Detail.find(p[0])
      package = package.update(p[1])
    end
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
