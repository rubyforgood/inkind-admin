class AddCityAndStateToStudents < ActiveRecord::Migration[6.1]
  def change
    add_column :students, :city, :string
    add_column :students, :state, :string, limit: 2
  end
end
