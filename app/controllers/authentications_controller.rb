class AuthenticationsController < Devise::OmniauthCallbacksController
  def gplus
    authorize 'gplus'
  end

  def facebook
    authorize 'facebook'
  end

  private

  def authorize(provider)
    session[:oauth] = env['omniauth.auth']
    if @user = Authentication.find_user(provider, env['omniauth.auth']['uid'])
      (flash[:notice] ||= []) << (I18n.t 'devise.sessions.signed_in')
      sign_in_and_redirect @user, :event => :authentication
    else
      (flash[:notice] ||= []) << (I18n.t 'devise.omniauth_callbacks.success', kind: (I18n.t "devise.authentications.providers.#{provider}_with_icon").html_safe).html_safe
      redirect_to oauth_bind_new_path
    end
  end
end
