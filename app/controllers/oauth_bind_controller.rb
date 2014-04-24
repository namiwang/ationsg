class OauthBindController < Devise::RegistrationsController
  before_filter :verify_session

  def new_from_oauth
    build_resource
    respond_with resource
  end

  def bind_with_oauth
    # TODO rescue if this email already use, or save failed, etc
    u = build_resource user_params
    u.password = Devise.friendly_token.first(20)
    # TODO clear this random password thing

    if !u.valid?
      @user.errors.full_messages.each do |m|
        (flash[:alert] ||= []) << m
      end
      redirect_to main_app.oauth_bind_new_path
      return
    end

    u.save!
    # TODO, rescue if save failed
    
    u.apply_authentication session[:oauth]
    # TODO these may be can be clearer, but just failed, seems because of some strong parament things

    flash[:notice] = I18n.t 'devise.registrations.signed_up'
    sign_in_and_redirect u, :event => :authentication
  end

  private

  def verify_session
    if session[:oauth].nil?
      redirect_to main_app.root_path, status: 403
    end
  end

  def user_params
    params.require(:user).permit(:email, :name, :phone)
  end
end