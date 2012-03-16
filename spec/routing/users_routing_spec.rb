require "spec_helper"

describe UsersController do
  it "routes post /users to users#create" do
    { post: "/users" }.should route_to(
      controller: "users",
      action: "create"
    )
  end

  it "routes get /users/<ID> to users#show" do
    { get: "/users/42" }.should route_to(
      controller: "users",
      action: "show",
      id: "42"
    )
  end
end
