require 'spec_helper'

describe "Static pages" do
  let(:page_title_base) { "SndStream" }
  subject { page }
  
  shared_examples_for "all static pages" do
    it { should have_selector 'h1', text: heading }
    it { should have_selector 'title', text: full_title(page_title) }
  end
  
  describe "Home page" do
    before { visit root_path }
    let(:heading) { "#{page_title_base}" }
    let(:page_title) { '' }
    
    it_should_behave_like "all static pages"
    it { should_not have_selector 'title', text: " | Home" }
    
    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:soundpost, user: user, content: "1101010")
        FactoryGirl.create(:soundpost, user: user, content: "1111010")
        sign_in user
        visit root_path
      end
      
      it "should render the user's feed" do
        user.feed.each do |post|
          page.should have_selector("li##{post.id}", text: post.content)
        end
      end
    end
  end
  
  describe "Help page" do
    before { visit help_path }
    let(:heading) { 'Help' }
    let(:page_title) { 'Help' }
    it_should_behave_like "all static pages"
  end
  
  describe "About page" do
    before { visit about_path }
    let(:heading) { 'About' }
    let(:page_title) { 'About' }
    it_should_behave_like "all static pages"
  end
  
  describe "Contact page" do
    before { visit contact_path }
    let(:heading) { 'Contact' }
    let(:page_title) { 'Contact' }
    it_should_behave_like "all static pages"
  end
  
  it "should have the right links on the layout " do
    visit root_path
    click_link "About"
    page.should have_selector 'title', text: full_title('About')
    click_link "Help"
    page.should have_selector 'title', text: full_title('Help')
    click_link "Contact"
    page.should have_selector 'title', text: full_title('Contact')
    click_link "Home"
    click_link "Sign up"
    page.should have_selector 'title', text: full_title('Sign Up')
    click_link "SndStream"
    page.should have_selector 'title', text: full_title('')
  end
end
