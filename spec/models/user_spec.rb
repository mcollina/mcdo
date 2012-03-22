require 'spec_helper'

describe User do

  subject { FactoryGirl.build(:user) }

  it { should be_valid }

  it "should not be valid without an email" do
    subject = FactoryGirl.build(:user, email: nil)
    subject.should_not be_valid
  end

  it "should not be valid without a password" do
    subject = FactoryGirl.build(:user, password: nil)
    subject.should_not be_valid
  end

  it "should have the right error message if it is without a password" do
    subject = FactoryGirl.build(:user, password: nil, password_confirmation: nil)
    subject.valid?
    subject.errors[:password].should == ["can't be blank"]
  end

  it "should not be valid if password and password_confirmation aren't equal" do
    subject = FactoryGirl.build(:user, password_confirmation: "425")
    subject.should_not be_valid
  end

  it "should have an unique email" do
    FactoryGirl.create(:user)
    subject.should_not be_valid
  end

  it "should authenticate successfully with the right password" do
    subject.save!
    subject.authenticate("my_pass").should be_true
  end

  it "should authenticate unsuccessfully with the wrong password" do
    subject.save!
    subject.authenticate("wrong_pass").should be_false
  end

  it "should not include the password_digest in its json" do
    subject.save!
    subject.as_json.should_not have_key("password_digest")
  end

  it { should have_and_belong_to_many(:lists) }

  it "should create a new list after creation" do
    expect {
      subject.save!
    }.to change(List, :count).by(1)
  end

  it "should not create a new list if it fails creation" do
    expect {
      FactoryGirl.build(:invalid_user).save
    }.not_to change(List, :count)
  end

  it "should order the lists by reverse update_at" do
    l1 = FactoryGirl.build(:list)
    subject.lists << l1
    subject.save!

    Timecop.freeze(Time.now + 1.minute) do
      l2 = FactoryGirl.build(:list)
      subject.lists << l2
      subject.save!

      subject.reload
      subject.lists.first.should == l2
    end
  end

  it "should order the lists by reverse update_at (disambiguation)" do
    l1 = FactoryGirl.build(:list)
    subject.lists << l1
    subject.save!

    l2 = FactoryGirl.build(:list)
    Timecop.freeze(Time.now + 1.minute) do
      subject.lists << l2
      subject.save!
    end

    Timecop.freeze(Time.now + 1.minute) do
      l1.touch
      subject.reload
      subject.lists.first.should == l1
    end
  end
end
