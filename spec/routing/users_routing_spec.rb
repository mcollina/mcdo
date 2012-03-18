require "spec_helper"

describe UsersController do
  it "routes post /users to users#create" do
    { post: "/users" }.should route_to(
      controller: "users",
      action: "create"
    )
  end
end
