require 'rails_helper'

RSpec.describe User, type: :model do
  it "has valid factory" do
    expect(create(:user)).to be_valid
  end

  it 'has roles' do
    admin = create(:user, :admin)
    expect(admin).to_not be_new_record
    expect(admin).to be_admin

    # expect(admin.role).to eq('admin')

    volunteer = create(:user, :volunteer)
    expect(volunteer).to_not be_new_record
    expect(volunteer).to be_volunteer
  end
end
