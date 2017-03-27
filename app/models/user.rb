class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:google_oauth2]

  def self.find_for_google_oauth2(access_token, signed_in_resource = nil)
    data = access_token.info
    user = Identity.where(provider: access_token.provider, uid: access_token.uid).try(:first).try(:user)
    if user
      return user
    else
      registered_user = User.where(email: access_token.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(name: data['name'],
                           email: data['email'],
                           password: Devise.friendly_token[0, 20])
        Identity.create(provider: access_token.provider,
                        uid: access_token.uid,
                        user: user)
        return user
      end
    end
  end

end
