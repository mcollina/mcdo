require 'spec_helper'

describe SessionsController do

  let(:user_attrs) { FactoryGirl.attributes_for(:user) }

  before :each do
    @user = User.create!(user_attrs)
  end

  describe "POST create" do

    def do_request(email = user_attrs[:email], password = user_attrs[:password])
      post :create, email: email, password: password, format: :json
    end

    describe "with right credentials" do

      it "should be a redirect" do
        do_request
        response.location.should == session_path
      end

      it "should return a json" do
        do_request
        response.content_type.should == "application/json"
      end

      it "should return a status indicator" do
        do_request
        response.body.should be_json_eql("authenticated".to_json).at_path("status")
      end

      it "should add the user_id to the session" do
        do_request
        session[:user_id].should == @user.id
      end
    end

    describe "with wrong credentials" do

      before :each do
        # we change the password in the hash
        # so the login can't succeed
        user_attrs[:password] += "bbb"
      end

      it "should have status 422" do
        do_request
        response.status.should == 422
      end

      it "should return a json" do
        do_request
        response.content_type.should == "application/json"
      end

      it "should return a status indicator" do
        do_request
        response.body.should be_json_eql("not authenticated".to_json).at_path("status")
      end
    end
  end

  describe "GET show" do
    def do_request
      get :show, format: :json
    end

    describe "with a logged in user" do

      before :each do
        session[:user_id] = @user.id
      end

      it "should be successful" do
        do_request
        response.should be_successful
      end

      it "should return a json" do
        do_request
        response.content_type.should == "application/json"
      end

      it "should return a status indicator" do
        do_request
        response.body.should be_json_eql("authenticated".to_json).at_path("status")
      end
    end

    describe "without a logged in user" do

      it "should not be successful" do
        do_request
        response.should_not be_successful
      end

      it "should return a json" do
        do_request
        response.content_type.should == "application/json"
      end

      it "should return a status indicator" do
        do_request
        response.body.should be_json_eql("not authenticated".to_json).at_path("status")
      end
    end
  end

  describe "DELETE destroy" do
    def do_request
      delete :destroy, format: :json
    end

    describe "with a logged in user" do

      before :each do
        session[:user_id] = @user.id
      end

      it "should be successful" do
        do_request
        response.should be_successful
      end

      it "should return a json" do
        do_request
        response.content_type.should == "application/json"
      end

      it "should return a status indicator" do
        do_request
        response.body.should be_json_eql("not authenticated".to_json).at_path("status")
      end

      it "should remove the user_id from the session" do
        do_request
        session[:user_id].should be_nil
      end
    end

    describe "without a logged in user" do

      it "should not be successful" do
        do_request
        response.should_not be_successful
      end

      it "should return a json" do
        do_request
        response.content_type.should == "application/json"
      end

      it "should return a status indicator" do
        do_request
        response.body.should be_json_eql("not authenticated".to_json).at_path("status")
      end
    end
  end
end
