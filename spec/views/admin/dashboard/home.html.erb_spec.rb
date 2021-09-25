require 'rails_helper'

RSpec.describe "admin/dashboard/home", type: :view do
  before(:each) do
    assign(:admin_dashboard, Admin::Dashboard.create!())
  end

  it "renders the admin dashboard" do
    render
  end
end
