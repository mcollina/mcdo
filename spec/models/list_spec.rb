require 'spec_helper'

describe List do
  subject { FactoryGirl.build(:list) }

  it { should have_db_column(:name) }

  it "should not be valid without a name" do
    subject = FactoryGirl.build(:list, name: nil)
    subject.should_not be_valid
  end

  it { should have_and_belong_to_many(:users) }

  it { should have_many(:items) }

  it "should create a new item after creation" do
    expect {
      subject.save!
    }.to change(Item, :count).by(1)
  end

  it "should not create a new list if it fails creation" do
    expect {
      FactoryGirl.build(:invalid_list).save
    }.not_to change(Item, :count)
  end
end
