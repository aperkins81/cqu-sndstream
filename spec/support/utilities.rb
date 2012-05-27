include ApplicationHelper

def valid_signin(user)
  fill_in "Email",    with: user.email
  fill_in "Password",  with: user.password
  click_button "Sign in"
  cookies[:remember_token] = user.remember_token
end

def sign_in(user)
  visit signin_path
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = user.remember_token
end

RSpec::Matchers.define :have_error_message do |err| match do |page|
    page.should have_selector('div.alert.alert-error', text: err)
  end
end

