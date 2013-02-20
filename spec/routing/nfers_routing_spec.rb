require "spec_helper"

describe NfersController do
  describe "routing" do

    it "routes to #index" do
      get("/nfers").should route_to("nfers#index")
    end

    it "routes to #new" do
      get("/nfers/new").should route_to("nfers#new")
    end

    it "routes to #show" do
      get("/nfers/1").should route_to("nfers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/nfers/1/edit").should route_to("nfers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/nfers").should route_to("nfers#create")
    end

    it "routes to #update" do
      put("/nfers/1").should route_to("nfers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/nfers/1").should route_to("nfers#destroy", :id => "1")
    end

  end
end
