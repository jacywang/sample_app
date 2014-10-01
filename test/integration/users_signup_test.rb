require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid submission information" do 
    get signup_path
    assert_no_difference "User.count" do
      post users_path, user: {name:" ", email:"user@invalid", password:"foo", password_confirmation:"bar"}
    end
    assert_template "users/new"
    assert_select "div#error_explanation"
    assert_select "div.field_with_errors"
  end 
  
  test "valid submission information" do
    get signup_path
    name="Example User"
    email="example@railsturotial.org"
    password="password"
    post_via_redirect users_path, user: {name:name, email:email, password:password, password_confirmation:password}
    assert_template 'users/show'
    assert_not flash.nil?
    assert is_logged_in?
  end
  
end
