class Contact < ActiveRecord::Base
  #######################
  ## Constants
  #######################
  #######################
  ## Associations
  #######################
  #######################
  ## Attribute Accessors
  #######################
  #specify that the signature is a paperclip file attachment
  #specify additional styles that you want to use in views or eslewhere
  has_attached_file :signature, :styles => {:thumb => "100x100>"}
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
  #######################
  ## Protected Methods
  #######################
  protected
  #######################
  ## Private Methods
  #######################
  private
end
