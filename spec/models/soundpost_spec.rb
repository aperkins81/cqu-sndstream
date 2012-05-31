require 'spec_helper'

describe Soundpost do
  let(:user) { FactoryGirl.create(:user) }
  before do
    @soundpost = user.soundposts.build(content: "Hello Binary")
  end
  subject { @soundpost }
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }
  it { should be_valid }
  
  describe "when fk user_id is not present" do
    before { @soundpost.user_id = nil }
    it { should_not be_valid }
  end
  
  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Soundpost.new(user_id: user.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
end
