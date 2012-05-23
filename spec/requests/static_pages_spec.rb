require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'SndStream'" do
      visit '/static_pages/home'
      page.should have_content('SndStream')
    end
    
    it "should have the right title" do
      visit '/static_pages/home'
      page.should have_selector('title', :text => "SndStream | Home")
    end
  end
  
  describe "Help page" do

    it "should have the content 'Help'" do
      visit '/static_pages/help'
      page.should have_content('Help')
    end
    
    it "should have the right title" do
      visit '/static_pages/help'
      page.should have_selector('title', :text => "SndStream | Help")
    end
  end
  
  describe "About page" do

    it "should have the content 'About'" do
      visit '/static_pages/about'
      page.should have_content('About')
    end
    
    it "should have the right title" do
      visit '/static_pages/about'
      page.should have_selector('title', :text => "SndStream | About")
    end
  end
end
