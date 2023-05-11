class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  http_basic_authenticate_with(
    name: ENV.fetch("AUTH_USER"),
    password: ENV.fetch("AUTH_PASSWORD")
  )
end
