require "rails_helper"

RSpec.describe Student, type: :model do
  let(:current_user) { create(:user, role: :admin) }

  it "has valid factory" do
    expect(create(:student)).to be_valid
  end

  context "associations" do
    it { is_expected.to belong_to(:deactivator).class_name("User").optional(true) }
    it { is_expected.to have_many(:student_volunteer_assignments) }
    it { is_expected.to have_many(:volunteers).through(:active_student_volunteer_assignments) }
    it { is_expected.to have_many(:student_staff_assignments) }

    describe "#active_student_volunteer_assignments" do
      it "returns assignment that is active" do
        student = create(:student)
        volunteer = create(:volunteer)
        volunteer2 = create(:volunteer)
        assignment = create(
          :student_volunteer_assignment,
          student: student,
          volunteer: volunteer,
          end_date: Date.current + 1.week
        )

        assignment2 = create(
          :student_volunteer_assignment,
          student: student,
          volunteer: volunteer2,
          end_date: Date.current + 1.week
        )

        expect(student.active_student_volunteer_assignments).to eq [assignment, assignment2]
      end

      it "returns nil when there is no active assignment" do
        student = create(:student)
        volunteer = create(:volunteer)
        create(
          :student_volunteer_assignment,
          student: student,
          volunteer: volunteer,
          end_date: Date.current - 1.week
        )

        expect(student.active_student_volunteer_assignments).to be_empty
      end
    end

    describe "#active_student_staff_assignment" do
      it "returns assignment that is active" do
        student = create(:student)
        staff = create(:staff)
        assignment = create(
          :student_staff_assignment,
          student: student,
          staff: staff,
          end_date: Date.current + 1.week
        )

        expect(student.active_student_staff_assignment).to eq assignment
      end

      it "returns nil when there is no active assignment" do
        student = create(:student)
        staff = create(:staff)
        create(
          :student_staff_assignment,
          student: student,
          staff: staff,
          end_date: Date.current - 1.week
        )

        expect(student.active_student_staff_assignment).to eq nil
      end
    end
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
  end

  context "enum" do
    it { is_expected.to define_enum_for(:status).with_values(active: 0, inactive: 1) }
  end

  it "joins to volunteers" do
    volunteer = create(:volunteer)
    student = create(:student)

    create(:student_volunteer_assignment, student: student, volunteer: volunteer)

    expect(student.volunteers).to include(volunteer)
  end

  it "joins to staff" do
    admin = create(:admin)
    student = create(:student)

    create(:student_staff_assignment, student: student, staff: admin)

    expect(student.staff).to eq admin
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
