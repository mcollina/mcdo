require 'spec_helper'

describe Item do

  subject { FactoryGirl.build(:item) }

  it { should have_db_column(:name) }

  it { should have_db_column(:position) }

  it "should not be valid without a name" do
    subject = FactoryGirl.build(:item, name: nil)
    subject.should_not be_valid
  end

  it "should not be valid without a list" do
    subject = FactoryGirl.build(:item, list: nil)
    subject.should_not be_valid
  end

  it { should belong_to(:list) }

  it "should initialize its position to the greatest in a list" do
    list = FactoryGirl.create(:list)
    item1 = FactoryGirl.create(:item, list: list)
    list.reload
    item2 = FactoryGirl.create(:item, list: list)
    list.reload
    item3 = FactoryGirl.create(:item, list: list)

    # but we count from 0
    item3.position.should == 3
  end
end
