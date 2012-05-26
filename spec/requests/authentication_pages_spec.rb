require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_selector('h1',    text: 'Sign in') }
    it { should have_selector('title', text: 'Sign in') }
    
    describe "with invalid information" do
      before { click_button "Sign in" }
      
      it { should have_selector('title', text: 'Sign in') }
      it { should have_error_message('Invalid') }
      
      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_error_message('Invalid') }
      end
    end
    
    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { valid_signin user }
      
      it { should have_selector('title', text: user.name) }
      it { should have_link('Profile', href: user_path(user)) }
      it { should_not have_link('Sign in', href: signin_path) }
    end
    

  end
end
