class AuthenticationsController < Devise::OmniauthCallbacksController
  def gplus
    authorize 'gplus'
  end

  private

  def authorize(provider)
    session[:oauth] = env['omniauth.auth']
    if @user = Authentication.find_user(provider, env['omniauth.auth']['uid'])
      # TODO make flash work in layout
      # flash[:notice] = I18n.t 'devise.sessions.signed_in'
      sign_in_and_redirect @user, :event => :authentication
    else
      # TODO make flash work in layout    
      # flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: (I18n.t "devise.oauth_services.providers.#{provider}")
      redirect_to oauth_bind_new_path
    end
  end
end
