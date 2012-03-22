require 'spec_helper'

describe Item do

  subject { FactoryGirl.build(:item) }

  it { should have_db_column(:name) }

  it "should not be valid without a name" do
    subject = FactoryGirl.build(:item, name: nil)
    subject.should_not be_valid
  end

  it "should not be valid without a list" do
    subject = FactoryGirl.build(:item, list: nil)
    subject.should_not be_valid
  end

  it { should belong_to(:list) }
end
