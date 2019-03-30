class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |_|
    redirect_to '/', alert: "Access denied"
  end

  def current_user
    if signed_in?
      super
    else
      dump_user_id = User.last.id + 1
      session[:user] = User.new(id: dump_user_id,
                                email: "#{dump_user_id}@session.com",
                                password: Devise.friendly_token[0, 20])
    end
  end

end
