require "rails_helper"

RSpec.describe Student, type: :model do
  let(:current_user) { create(:user, role: :admin) }

  it "has valid factory" do
    expect(create(:student)).to be_valid
  end

  it "joins to users" do
    volunteer = create(:user, :volunteer)
    student = create(:student)

    student.users << volunteer

    expect(volunteer.students).to include(student)
  end

  context "activation" do
    it "can be activated" do
      student = create(:student, status: "inactive")
      expect(student.status).to eq("inactive")

      student.activate!
      expect(student.status).to eq("active")
    end

    it "can be deactivated" do
      student = create(:student)

      student.deactivate!(deactivator_id: current_user.id)
      expect(student.status).to eq("inactive")
      expect(student.deactivated_at).to_not be_nil
      expect(student.deactivator_id).to eq(current_user.id)
    end
  end
end
