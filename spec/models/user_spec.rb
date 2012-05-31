# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe User do
  before do
    @user = User.new(name: "Example User", email: "user@example.com",
        password: "chicken", password_confirmation: "chicken")
  end
  
  subject { @user }
  it { should respond_to :name }
  it { should respond_to :email }
  it { should respond_to :password_digest }
  it { should respond_to :password }
  it { should respond_to :password_confirmation }
  it { should respond_to :remember_token }
  it { should respond_to :admin }
  it { should respond_to :authenticate }
  it { should respond_to :soundposts }
  it { should respond_to :feed }
  it { should be_valid }
  it { should_not be_admin }
  
  describe "with admin attribute set to true" do
    before { @user.toggle!(:admin) }
    
    it { should be_admin }
  end
  
  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end
  
  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end
  
  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end
  
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[asdf@asdf,com asdf_at_asdf.com asdf@asdf. 
          asdf@asdf_fdsa.com asdf@asdf+asdf.com]
      addresses.each do |invalid|
        @user.email = invalid
        @user.should_not be_valid
      end
    end
  end
  
  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[asdf@asdf.COM asdf_asdf-asdf@a.b.com fda.asdf@dsfds.d.foo
          asd+fsdf@asdf.fdsa]
      addresses.each do |valid|
        @user.email = valid
        @user.should be_valid
      end
    end
  end
  
  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end
    it { should_not be_valid }
  end
  
  describe "email address with mixed case" do
    let(:mixed_case_email) { "AsDf@fSDa.cOM" }
    it "should be saved as all lower-case" do
      @user.email = mixed_case_email
      @user.save
      @user.reload.email.should == mixed_case_email.downcase
    end
  end
  
  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end
  
  describe "when password does not match confirmation" do
    before { @user.password_confirmation = "not_chicken" }
    it { should_not be_valid }
  end
  
  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end
  
  describe "return value of authentication method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email)}
    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end
    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("not_chicken") }
      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end
  
  describe "with a password that is too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end
  
  describe "soundpost associations" do
    before { @user.save }
    let!(:older_soundpost) do
      FactoryGirl.create(:soundpost, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_soundpost) do
      FactoryGirl.create(:soundpost, user: @user, created_at: 1.hour.ago)
    end
    
    it "should have the right soundposts in the right order" do
      @user.soundposts.should == [newer_soundpost, older_soundpost]
    end
    
    it "should destroy associated soundposts" do
      soundposts = @user.soundposts
      @user.destroy
      soundposts.each do |soundpost|
        Soundpost.find_by_id(soundpost.id).should be_nil
      end
    end
    
    describe "status" do
      let(:unfollowed_post) do
        FactoryGirl.create(:soundpost, user: FactoryGirl.create(:user))
      end
      
      its(:feed) { should include(newer_soundpost) }
      its(:feed) { should include(older_soundpost) }
      its(:feed) { should_not include(unfollowed_post) }
    end
  end
end
