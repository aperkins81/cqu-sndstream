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
    end
    
    describe "with valid information" do
      before do
        fill_in "Name",         with: "Some One"
        fill_in "Email",        with: "some@one.com"
        fill_in "Password",     with: "somepass"
        fill_in "Confirmation", with: "somepass"
      end
      # this address found in spec/views/factories.rb
        let(:user) { User.find_by_email('test@email.com') }
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      
      describe "after saving the user" do
        before { click_button submit }
        
        # this address found in spec/views/factories.rb
        let(:user) { User.find_by_email('test@email.com') }
        it { should have_selector('title', text: user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
      
      describe "after submission" do
        before {click_button submit }
        it { should have_selector('title', text: 'Sign up')}
        it { should have_content('error') }
      end
    end
    
  end
  
end
