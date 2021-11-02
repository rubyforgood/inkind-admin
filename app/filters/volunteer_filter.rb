class VolunteerFilter < AllFutures
  # Facets - here be search + filters

  # Pagination
  attribute :items, :integer, default: 2
  attribute :page, :integer, default: 1

  # Sorting
  attribute :order, :string, default: "last_name"
  attribute :direction, :string, default: "asc"

  def scope
    User
      .volunteer
      .order(order => direction)
  end
end
