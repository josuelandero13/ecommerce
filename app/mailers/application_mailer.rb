# frozen_string_literal: true

# Class for mailers
class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@easybuy.com'
  layout 'mailer'
end
