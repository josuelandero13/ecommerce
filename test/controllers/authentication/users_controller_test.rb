# frozen_string_literal: true

require 'test_helper'

# Test for user authentication
class Authentication::UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get new_user_url
    assert_response :success
  end

  test 'should create user' do
    stub_request(:get, 'http://ip-api.com/json/127.0.0.1').
      to_return(status: 200, body: {
        status: 'fail'
      }.to_json, headers: {})

    assert_difference('User.count') do
      post users_url, params: { user: {
        email: 'juan@easybuy.com',
        username: 'juan0920',
        password: 'testme'
      } }
    end

    assert_redirected_to products_url
  end
end
