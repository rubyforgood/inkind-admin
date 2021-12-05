# frozen_string_literal: true

class StudentsTableReflex < ApplicationReflex
  include SortHelper

  def sort
    sort_records(records: Student.all,
      partial: "students_table",
      sort_columns: %w[first_name last_name guardian_name])
  end
end
