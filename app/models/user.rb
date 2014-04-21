class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:gplus]

  # associations
  has_many :authentications, dependent: :destroy
  has_many :orders

  def apply_authentication(oauth_info)
   authentications.build(
     provider: oauth_info['provider'],
     uid: oauth_info['uid']
   )
   self.save!
  end

end
