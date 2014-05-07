class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:gplus, :facebook]

  # validations
  
  # associations
  has_many :authentications, dependent: :destroy
  has_many :orders

  # votable
  acts_as_voter

  def apply_authentication(oauth_info)
   authentications.build(
     provider: oauth_info['provider'],
     uid: oauth_info['uid']
   )
   self.save!
  end

end
