# frozen_string_literal: true

require_relative "./reflex_helper"

RSpec.describe StudentsTableReflex, type: :reflex do
  let(:reflex) { build_reflex(url: admin_students_path) }

  describe "#sort" do
    before do
      2.times do
        create(:student, status: :active)
        create(:student, status: :inactive)
      end
    end

    it_behaves_like "sortable table", "first_name", Student.all, "admin/students/_students_table"
    it_behaves_like "sortable table", "last_name", Student.all, "admin/students/_students_table"
    it_behaves_like "sortable table", "guardian_last_name", Student.all, "admin/students/_students_table"
    it_behaves_like "sortable table", "status", Student.all, "admin/students/_students_table"
  end
end
