# frozen_string_literal: true

require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  def setup
    @user = User.last
  end

  test 'welcome' do
    mail = UserMailer.with(user: @user).welcome
    assert_equal 'Bienvenido a Compra Facil', mail.subject
    assert_equal [@user.email], mail.to
    assert_equal ['no-reply@easybuy.com'], mail.from
    assert_match "Hey #{@user.username}, bienvenid@ a Compra Facil.", mail.body.encoded
  end
end
