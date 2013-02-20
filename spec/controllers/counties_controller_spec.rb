require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe CountiesController do

  # This should return the minimal set of attributes required to create a valid
  # County. As you add validations to County, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { "name" => "MyString" }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CountiesController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all counties as @counties" do
      county = County.create! valid_attributes
      get :index, {}, valid_session
      assigns(:counties).should eq([county])
    end
  end

  describe "GET show" do
    it "assigns the requested county as @county" do
      county = County.create! valid_attributes
      get :show, {:id => county.to_param}, valid_session
      assigns(:county).should eq(county)
    end
  end

  describe "GET new" do
    it "assigns a new county as @county" do
      get :new, {}, valid_session
      assigns(:county).should be_a_new(County)
    end
  end

  describe "GET edit" do
    it "assigns the requested county as @county" do
      county = County.create! valid_attributes
      get :edit, {:id => county.to_param}, valid_session
      assigns(:county).should eq(county)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new County" do
        expect {
          post :create, {:county => valid_attributes}, valid_session
        }.to change(County, :count).by(1)
      end

      it "assigns a newly created county as @county" do
        post :create, {:county => valid_attributes}, valid_session
        assigns(:county).should be_a(County)
        assigns(:county).should be_persisted
      end

      it "redirects to the created county" do
        post :create, {:county => valid_attributes}, valid_session
        response.should redirect_to(County.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved county as @county" do
        # Trigger the behavior that occurs when invalid params are submitted
        County.any_instance.stub(:save).and_return(false)
        post :create, {:county => { "name" => "invalid value" }}, valid_session
        assigns(:county).should be_a_new(County)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        County.any_instance.stub(:save).and_return(false)
        post :create, {:county => { "name" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested county" do
        county = County.create! valid_attributes
        # Assuming there are no other counties in the database, this
        # specifies that the County created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        County.any_instance.should_receive(:update_attributes).with({ "name" => "MyString" })
        put :update, {:id => county.to_param, :county => { "name" => "MyString" }}, valid_session
      end

      it "assigns the requested county as @county" do
        county = County.create! valid_attributes
        put :update, {:id => county.to_param, :county => valid_attributes}, valid_session
        assigns(:county).should eq(county)
      end

      it "redirects to the county" do
        county = County.create! valid_attributes
        put :update, {:id => county.to_param, :county => valid_attributes}, valid_session
        response.should redirect_to(county)
      end
    end

    describe "with invalid params" do
      it "assigns the county as @county" do
        county = County.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        County.any_instance.stub(:save).and_return(false)
        put :update, {:id => county.to_param, :county => { "name" => "invalid value" }}, valid_session
        assigns(:county).should eq(county)
      end

      it "re-renders the 'edit' template" do
        county = County.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        County.any_instance.stub(:save).and_return(false)
        put :update, {:id => county.to_param, :county => { "name" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested county" do
      county = County.create! valid_attributes
      expect {
        delete :destroy, {:id => county.to_param}, valid_session
      }.to change(County, :count).by(-1)
    end

    it "redirects to the counties list" do
      county = County.create! valid_attributes
      delete :destroy, {:id => county.to_param}, valid_session
      response.should redirect_to(counties_url)
    end
  end

end
