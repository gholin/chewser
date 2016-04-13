class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # Want to authenticate whole site so I put it here instead of on any given page
  http_basic_authenticate_with name: "me", password: "pw"
end
