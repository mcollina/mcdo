require 'spec_helper'

describe ItemsController do

  let(:user) { FactoryGirl.create(:user) }

  let(:list) { user.lists.first }

  before :each do
    session[:user_id] = user.id
  end

  describe "POST create" do

    render_views

    def do_request
      item.delete(:list_id)
      post :create, { format: :json, list_id: list.id, item: item }
    end

    describe "with valid params" do

      let(:item) { FactoryGirl.attributes_for(:item) }

      it "should save an Item" do
        expect{ do_request }.to change(Item, :count).by(1)
      end

      it "should be successful" do
        do_request
        response.should be_successful
      end

      it "should return a json" do
        do_request
        response.content_type.should == "application/json"
      end

      it "should attach the item to the current list" do
        do_request
        list.reload
        item = Item.order("created_at DESC").first
        list.items.should include(item)
      end

      it "should show the item name in the json" do
        do_request
        response.body.should be_json_eql(item[:name].to_json).at_path("name")
      end

      it "should show the link to the list in the json" do
        do_request
        response.body.should be_json_eql(list_path(list, only_path: false).to_json).at_path("list_link")
      end
    end

    describe "with invalid params" do

      let(:item) { FactoryGirl.attributes_for(:invalid_item) }

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
        copy = Item.new(item)
        copy.list = list
        copy.valid?
        response.body.should be_json_eql(copy.errors.to_json).at_path("errors")
      end
    end
  end

  describe "GET index" do

    render_views

    def do_request
      get :index, format: :json, list_id: list.id
    end

    it "should render the list items" do
      do_request
      items_json = list.items.as_json.map { |i| i.delete("list_id"); i }
      response.body.should be_json_eql(items_json.to_json).at_path("items")
    end

    it "should render a link to the list" do
      do_request
      response.body.should be_json_eql(list_path(list, only_path: false).to_json).at_path("list_link")
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

  describe "GET show" do

    render_views

    def do_request(id=item.id, list_id=list.id)
      get :show, format: :json, id: id, list_id: list_id
    end

    describe "with valid params" do

      let(:item) { list.items.first }

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
        response.body.should be_json_eql(item.name.to_json).at_path("name")
      end

      it "should show the a link to the list in the json" do
        do_request
        response.body.should be_json_eql(list_path(list, only_path: false).to_json).at_path("list_link")
      end
    end
  end

  describe "PUT update" do

    render_views

    def do_request(new_name = "aaaa", id=item.id, list_id=list.id)
      put :update, format: :json, id: id, list_id: list_id, item: { name: new_name }
    end

    describe "with valid params" do

      let(:item) { list.items.first }

      it "should update the name of the item" do
        do_request "my new item name"
        item.reload
        item.name.should == "my new item name"
      end

      it "should be successful" do
        do_request
        response.should be_successful
      end

      it "should return a json" do
        do_request
        response.content_type.should == "application/json"
      end

      it "should show the item name in the json" do
        do_request "my new item name"
        response.body.should be_json_eql("my new item name".to_json).at_path("name")
      end
    end
  end

  describe "DELETE destroy" do

    def do_request(id=item.id, list_id=list.id)
      delete :destroy, format: :json, id: id, list_id: list.id
    end

    describe "with valid params" do

      let(:item) { list.items.first }

      it "should destroy an item" do
        expect{ do_request }.to change(Item, :count).by(-1)
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

  describe "PUT move" do

    def do_request(new_position = 42, id=item.id, list_id=list.id)
      put :move, format: :json, id: id, list_id: list_id, position: new_position
    end

    describe "with valid params" do

      let(:item) { list.items.first }

      it "should call the move method on the list" do
        list = double("list")
        list.should_receive(:move).with(item_id: item.id.to_s, position: 2.to_s)
        User.stub_chain(:find, :lists, :find).and_return(list)
        do_request 2
      end

      it "should be successful" do
        do_request
        response.should be_successful
      end

      it "should return a json" do
        do_request
        response.content_type.should == "application/json"
      end

      it "should show render the index template" do
        do_request
        response.should render_template("index")
      end
    end
  end
end
