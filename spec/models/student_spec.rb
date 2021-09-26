require "rails_helper"

RSpec.describe Student, type: :model do
  it "has valid factory" do
    expect(create(:student)).to be_valid
  end

  it "joins to users" do
    volunteer = create(:user, :volunteer)
    student = create(:student)

    student.users << volunteer

    expect(volunteer.students).to include(student)
  end
end
