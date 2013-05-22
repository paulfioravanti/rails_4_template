require 'spec_helper'

describe "Routing" do
  it "routes / to pages#home" do
    expect(get("/")).to route_to("pages#home")
  end

  it "routes /register to users#new" do
    expect(get("/register")).to route_to("users#new")
  end

  it "routes /signin to sessions#new" do
    expect(get("/signin")).to route_to("sessions#new")
  end

  it "routes /signout to sessions#destroy" do
    expect(delete("/signout")).to route_to("sessions#destroy")
  end
end