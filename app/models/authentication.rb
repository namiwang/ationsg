class Authentication < ActiveRecord::Base
  # associations
  belongs_to :user

  # validations
  validates_presence_of :provider, :uid

  class << self
    def find_user(provider, uid)
      Authentication.where(provider: provider, uid: uid).first.try(:user)
    end
  end
end
