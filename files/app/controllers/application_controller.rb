class ApplicationController < ActionController::Base
  include Authenticatable
  protect_from_forgery
end