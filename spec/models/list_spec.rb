require 'spec_helper'

describe List do
  subject { FactoryGirl.build(:list) }

  it { should have_db_column(:name) }

  it "should not be valid without a name" do
    subject = FactoryGirl.build(:list, name: nil)
    subject.should_not be_valid
  end

  it { should have_and_belong_to_many(:users) }
end
