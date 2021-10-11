require "rails_helper"

RSpec.describe Admin::StudentsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/admin/students").to route_to("admin/students#index")
    end

    it "routes to #new" do
      expect(get: "/admin/students/new").to route_to("admin/students#new")
    end

    it "routes to #show" do
      expect(get: "/admin/students/1").to route_to("admin/students#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/admin/students/1/edit").to route_to("admin/students#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/admin/students").to route_to("admin/students#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/admin/students/1").to route_to("admin/students#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/admin/students/1").to route_to("admin/students#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/admin/students/1").to route_to("admin/students#destroy", id: "1")
    end
  end
end
