# frozen_string_literal: true

class StudentsTableReflex < ApplicationReflex
  include TableHelper

  def sort
    sort_records(records: Student.all,
      partial: "students_table",
      columns: %w[first_name last_name guardian_last_name status])
  end
end
