require "application_system_test_case"

class AuthenticationTest < ApplicationSystemTestCase
  test "signing up a new user" do
    visit signup_url
  
    fill_in "Name", with: "System Test User"
    fill_in "Email", with: "system@test.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
  
    click_button "Sign Up"
  
    assert_text "Hi, System Test User"
  end
end
