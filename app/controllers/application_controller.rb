# frozen_string_literal: true

# Main application controller
class ApplicationController < ActionController::Base
  include Authentication
  include Authorization
  include Language
  include Pagy::Backend
  include Error
end
