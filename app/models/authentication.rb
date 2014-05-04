class Authentication < ActiveRecord::Base
  # associations
  belongs_to :user

  # validations
  validates_presence_of :user, :provider, :uid
  validates_inclusion_of :provider, :in => %w( gplus facebook ), message: 'not valid provider'
  # TODO message i18n


  class << self
    def find_user(provider, uid)
      Authentication.where(provider: provider, uid: uid).first.try(:user)
    end
  end
end
