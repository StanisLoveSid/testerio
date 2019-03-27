class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |_|
    redirect_to '/', alert: "Access denied"
  end
end
