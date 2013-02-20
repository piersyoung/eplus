require "spec_helper"

describe DayboardsController do
  describe "routing" do

    it "routes to #index" do
      get("/dayboards").should route_to("dayboards#index")
    end

    it "routes to #new" do
      get("/dayboards/new").should route_to("dayboards#new")
    end

    it "routes to #show" do
      get("/dayboards/1").should route_to("dayboards#show", :id => "1")
    end

    it "routes to #edit" do
      get("/dayboards/1/edit").should route_to("dayboards#edit", :id => "1")
    end

    it "routes to #create" do
      post("/dayboards").should route_to("dayboards#create")
    end

    it "routes to #update" do
      put("/dayboards/1").should route_to("dayboards#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/dayboards/1").should route_to("dayboards#destroy", :id => "1")
    end

  end
end
