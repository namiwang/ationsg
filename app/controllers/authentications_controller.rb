class AuthenticationsController < Devise::OmniauthCallbacksController
  def gplus
    authorize 'gplus'
  end

  private

  def authorize(provider)
    session[:oauth] = env['omniauth.auth']
    if @user = Authentication.find_user(provider, env['omniauth.auth']['uid'])
      (flash[:notice] ||= []) << I18n.t 'devise.sessions.signed_in'
      sign_in_and_redirect @user, :event => :authentication
    else
      (flash[:notice] ||= []) << I18n.t 'devise.omniauth_callbacks.success', kind: (I18n.t "devise.oauth_services.providers.#{provider}")
      redirect_to oauth_bind_new_path
    end
  end
end
