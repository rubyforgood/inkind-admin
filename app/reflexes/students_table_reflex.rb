# frozen_string_literal: true

class StudentsTableReflex < ApplicationReflex
  def sort
    students = Student.order("#{element.dataset.column} #{element.dataset.direction}")

    morph "#students", render(partial: "students_table", locals: {students: students})

    set_sort_direction if next_direction(element.dataset.direction) == "desc"
    insert_indicator
  end

  private

  def next_direction(direction)
    direction == "asc" ? "desc" : "asc"
  end

  def set_sort_direction
    cable_ready
      .set_dataset_property(
        selector: "##{element.id}",
        name: "direction",
        value: next_direction(element.dataset.direction)
      )
  end

  def insert_indicator
    cable_ready
      .prepend(
        selector: "##{element.id}",
        html: render(
          partial: "admin/students/sort_indicator",
          locals: {direction: element.dataset.direction}
        )
      )
  end
end
