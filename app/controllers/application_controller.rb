# frozen_string_literal: true

# this controller is parent for all controllers
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[username avatar])
  end
end
