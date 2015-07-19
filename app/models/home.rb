class Home < ActiveRecord::Base
  #######################
  ## Constants
  #######################
  #######################
  ## Associations
  #######################
  #######################
  ## Attribute Accessors
  #######################
  #######################
  ## scopes
  #######################
  scope :last_cut_off_time, -> { where("cut_off_time IS NOT NULL").order("created_at DESC")}
  scope :match_user, ->(user) { where("user_id = ?", user).order("created_at DESC")}
  #scope :promoted_to_home, where("`videos`.deleted_at IS NULL AND `videos`.published_at IS NOT NULL AND `videos`.promoted_to_home IS TRUE AND `videos`.content_mobile IS FALSE").order("`videos`.updated_at DESC")
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
