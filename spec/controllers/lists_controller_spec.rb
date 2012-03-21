require 'spec_helper'

describe ListsController do

  let(:user) { FactoryGirl.create(:user) }

  before :each do
    session[:user_id] = user.id
  end

  describe "POST create" do

    def do_request
      post :create, { format: :json, list: list}
    end

    describe "with valid params" do

      let(:list) { FactoryGirl.attributes_for(:list) }

      it "should save a list" do
        expect{ do_request }.to change(List, :count).by(1)
      end

      it "should be successful" do
        do_request
        response.should be_successful
      end

      it "should return a json" do
        do_request
        response.content_type.should == "application/json"
      end

      it "should show the list's JSON" do
        do_request
        response.body.should be_json_eql(List.order("created_at DESC").first.to_json)
      end

      it "should attach the list to the current user" do
        do_request
        List.first.users.should include(user)
      end
    end

    describe "with invalid params" do

      let(:list) { FactoryGirl.attributes_for(:invalid_list) }

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
        copy = List.new(list)
        copy.valid?
        response.body.should be_json_eql(copy.errors.to_json).at_path("errors")
      end
    end
  end

  describe "GET index" do

    render_views

    def do_request
      get :index, format: :json
    end

    it "should render the user's list" do
      do_request
      json_lists = user.lists.inject([]) do |acc, list| 
        acc << list.as_json.merge(link: list_path(list, only_path: false))
        acc
      end
      response.body.should be_json_eql(json_lists.to_json).at_path("lists")
    end

    it "should be a json" do
      do_request
      response.content_type.should == "application/json"
    end

    it "should be successful" do
      do_request
      response.should be_successful
    end

    describe "without a user" do

      before :each do
        session[:user_id] = nil
      end

      it "should return status code 403" do
        do_request
        response.status.should == 403
      end
    end
  end

  describe "DELETE destroy" do

    def do_request(id=list.id)
      delete :destroy, format: :json, id: id
    end

    describe "with valid params" do

      let(:list) { FactoryGirl.build(:list) }

      before :each do
        list.users << user
        list.save!
      end

      it "should destroy a list" do
        expect{ do_request }.to change(List, :count).by(-1)
      end

      it "should be successful" do
        do_request
        response.should be_successful
      end

      it "should return a json" do
        do_request
        response.content_type.should == "application/json"
      end
    end
  end

  describe "PUT update" do

    render_views

    def do_request(new_name = "aaaa", id=list.id)
      put :update, format: :json, id: id, list: { name: new_name }
    end

    describe "with valid params" do

      let(:list) { FactoryGirl.build(:list) }

      before :each do
        list.users << user
        list.save!
      end

      it "should update the name of the list" do
        do_request "my new list name"
        list.reload
        list.name.should == "my new list name"
      end

      it "should be successful" do
        do_request
        response.should be_successful
      end

      it "should return a json" do
        do_request
        response.content_type.should == "application/json"
      end

      it "should show the list name in the json" do
        do_request "my new list name"
        response.body.should be_json_eql("my new list name".to_json).at_path("name")
      end
    end
  end

  describe "GET show" do

    render_views

    def do_request(id=list.id)
      get :show, format: :json, id: id
    end

    describe "with valid params" do

      let(:list) { FactoryGirl.build(:list) }

      before :each do
        list.users << user
        list.save!
      end

      it "should be successful" do
        do_request
        response.should be_successful
      end

      it "should return a json" do
        do_request
        response.content_type.should == "application/json"
      end

      it "should show the list name in the json" do
        do_request
        response.body.should be_json_eql(list.name.to_json).at_path("name")
      end
    end
  end
end
