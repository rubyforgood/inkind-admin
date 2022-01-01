# frozen_string_literal: true

class VolunteersTableReflex < ApplicationReflex
  include TableHelper

  def sort
    sort_records(records: records, columns: %w[first_name last_name status])
  end

  def filter
    filter_records(records: records,
      columns: {"first_name" => :fuzzy,
                "last_name" => :fuzzy,
                "status" => :exact})
  end

  private

  def records
    return @records if defined?(@records)

    @records = User.where(role: :volunteer)
  end

  def partial
    "volunteers_table"
  end

  def special_filters
    %w[staff_names]
  end

  def run_special_filters(filters:, records:)
    filter_by_staff_name(staff_name: filters["staff_names"], records: records)
  end

  def filter_by_staff_name(staff_name:, records:)
    return records if staff_name.blank?

    records
      .left_outer_joins(student_volunteer_assignments: {student: {active_student_staff_assignment: :staff}})
      .where("concat(staffs_student_staff_assignments.first_name, ' ', staffs_student_staff_assignments.last_name) ilike ?", "%#{staff_name}%").distinct
  end
end
