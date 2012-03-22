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

  it { should respond_to(:move) }

  it "should move a single object" do
    subject.save

    lambda {
      subject.move(item_id: subject.items.first.id, position: 42)
    }.should_not raise_error
  end

  describe "#move with three objects" do

    before :each do
      # save and clear it from previous items
      subject.save
      subject.items.clear
      subject.save
      subject.reload

      @item1 = FactoryGirl.create(:item, list_id: subject.id)
      subject.reload
      @item2 = FactoryGirl.create(:item, list_id: subject.id)
      subject.reload
      @item3 = FactoryGirl.create(:item, list_id: subject.id)
      subject.reload
    end

    it "should move an item to the top" do
      subject.move(item_id: @item3.id, position: 0)
      subject.items.should == [@item3, @item1, @item2]
    end

    it "should move an item to the middle" do
      subject.move(item_id: @item1.id, position: 1)
      subject.items.should == [@item2, @item1, @item3]
    end

    it "should move an item to the bottom" do
      subject.move(item_id: @item1.id, position: 2)
      subject.items.should == [@item2, @item3, @item1]
    end

    it "should accepts a string for a position" do
      lambda {
        subject.move(item_id: @item1.id, position: "2")
      }.should_not raise_error
    end
  end
end
