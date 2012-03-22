require "spec_helper"

describe ItemsController do
  it "routes post /lists/1/items to items#create" do
    { post: "/lists/1/items" }.should route_to(
      controller: "items",
      action: "create",
      list_id: "1"
    )
  end

  it "routes get /lists/1/items to items#index" do
    { get: "/lists/1/items" }.should route_to(
      controller: "items",
      action: "index",
      list_id: "1"
    )
  end

  it "routes get /lists/1/items/42 to items#show" do
    { get: "/lists/1/items/42" }.should route_to(
      controller: "items",
      action: "show",
      id: "42",
      list_id: "1"
    )
  end

  it "routes put /lists/1/items/42 to items#update" do
    { put: "/lists/1/items/42" }.should route_to(
      controller: "items",
      action: "update",
      id: "42",
      list_id: "1"
    )
  end

  it "routes delete /lists/1/items/42 to items#destroy" do
    { delete: "/lists/1/items/42" }.should route_to(
      controller: "items",
      action: "destroy",
      id: "42",
      list_id: "1"
    )
  end

  it "routes put /lists/1/items/42/move to items#move" do
    { put: "/lists/1/items/42/move" }.should route_to(
      controller: "items",
      action: "move",
      id: "42",
      list_id: "1"
    )
  end
end
