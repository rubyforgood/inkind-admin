# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::DashboardController, type: :routing do
  describe 'routing' do
    it 'routes to #home' do
      expect(get: '/admin/dashboard').to route_to('admin/dashboard#home')
    end
  end
end
