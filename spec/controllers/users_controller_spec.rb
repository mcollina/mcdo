require 'spec_helper'

describe UsersController do

  describe "POST create" do

    def do_request
      post :create, { format: :json, user: user}
    end

    describe "with valid params" do

      let(:user) { FactoryGirl.attributes_for(:user) }

      it "should save a User" do
        expect{ do_request }.to change(User, :count).by(1)
      end

      it "should have contain a location header" do
        do_request
        response.location.should == user_url(User.first)
      end

      it "should be succesful" do
        do_request
        response.should be_successful
      end

      it "should return a json" do
        do_request
        response.content_type.should == "application/json"
      end

      it "should add the user_id to the session" do
        do_request
        session[:user_id].should == User.first.id
      end
    end

    describe "with invalid params" do

      let(:user) { FactoryGirl.attributes_for(:invalid_user) }

      it "should have status 422" do
        do_request
        response.status.should == 422
      end

      it "should be a json" do
        do_request
        response.content_type.should == "application/json"
      end

      it "should include the errors in the errors path" do
        do_request
        copy = User.new(user)
        copy.valid?
        response.body.should be_json_eql(copy.errors.to_json).at_path("errors")
      end
    end
  end
end
