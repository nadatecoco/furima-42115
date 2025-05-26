class ApplicationController < ActionController::Base
  before_action :basic_auth, if: -> { Rails.env.production? }
  before_action :configure_permitted_parameters, if: :devise_controller

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['USER_NAME'] && password == ENV['PASSWORD']
    end
  end

  def configure_permitted_parameters
    keys = [:nickname,
            :last_name,
            :first_name,
            :kana_last_name,
            :kana_first_name,
            :birthday]
    devise_parameter_sanitizer.permit(:sign_up, keys: keys)
  end
end
