require "spec_helper"

describe ListsController do
  it "routes post /lists to lists#create" do
    { post: "/lists" }.should route_to(
      controller: "lists",
      action: "create"
    )
  end

  it "routes get /lists to lists#index" do
    { get: "/lists" }.should route_to(
      controller: "lists",
      action: "index"
    )
  end

  it "routes get /lists/1 to lists#show" do
    { get: "/lists/1" }.should route_to(
      controller: "lists",
      action: "show",
      id: "1"
    )
  end

  it "routes put /lists/1 to lists#update" do
    { put: "/lists/1" }.should route_to(
      controller: "lists",
      action: "update",
      id: "1"
    )
  end

  it "routes delete /lists/1 to lists#destroy" do
    { delete: "/lists/1" }.should route_to(
      controller: "lists",
      action: "destroy",
      id: "1"
    )
  end
end
