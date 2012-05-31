require 'spec_helper'

describe "Soundpost pages" do
  subject { page }
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }
  
  describe "micropost creation" do
    before { visit root_path }
    
    describe "with invalid information" do
#      it "should not create a soundpost" do
#        expect { click_button "Post" }.should_not change(Soundpost, :count)
#      end
    
      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end
    
    describe "with valid information" do
      before { fill_in "soundpost_content", with: "001011010010" }
      it " should create a micropost" do
        expect { click_button "Post" }.should change(Soundpost, :count).by(1)
      end
    end
  end
end
