require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_selector('h1',    text: user.name) }
    it { should have_selector('title', text: user.name) }
  end
  
  describe "signup" do
    before { visit signup_path }
    let(:submit) { "Create my account" }
    
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
      
      describe "after submission" do
        it { should have_selector('title', text: 'Sign Up')}
        it { should have_selector('div', id: 'error_explanation') }
      end
    end
    
    describe "with valid information" do
      before do
        #visit signup_path
        fill_in "Name",         with: "Test User"
        fill_in "Email",        with: "test@email.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
        expect do
          click_button submit 
        end.to change(User, :count).by(1)
      end
      
      describe "after saving the user" do
        # this address found in spec/views/factories.rb
        let(:user) { User.find_by_email('test@email.com') }
        
        it { should have_selector('title', text: user.name) }
        it { should have_selector('div.alert.alert-success', text: "G'day there") }
        it { should have_link('Sign out') }
      end
      
      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link 'Sign in'}
      end
      

    end
    
  end
  
end
