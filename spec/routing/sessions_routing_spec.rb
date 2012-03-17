require "spec_helper"

describe SessionsController do
  it "routes post /session to session#create" do
    { post: "/session" }.should route_to(
      controller: "sessions",
      action: "create"
    )
  end

  it "routes get /session to session#show" do
    { get: "/session" }.should route_to(
      controller: "sessions",
      action: "show"
    )
  end

  it "routes delete /session to session#destroy" do
    { delete: "/session" }.should route_to(
      controller: "sessions",
      action: "destroy"
    )
  end
end
