# frozen_string_literal: true

class VolunteersReflex < ApplicationReflex
  def paginate
    facet do |filter|
      filter[:page] = element.dataset.page
    end
  end

  def sort
    facet do |filter|
      filter[:order] = element.dataset.order
      filter[:direction] = element.dataset.direction
    end
  end

  private

  def facet
    filter = VolunteerFilter.find(element.dataset.filter)
    yield filter
    pagy, volunteers = pagy(filter.scope, page: filter.page, items: filter.items)
    puts volunteers
    puts "dupa"
    # Reflex Volunteers#paginate failed: undefined method `id' for nil:NilClass [http://localhost:3001/admin/volunteers]
    # Reflex Volunteers#sort failed: undefined method `id' for nil:NilClass [http://localhost:3001/admin/volunteers]
    # Morphs receive filter and volunteers (paginated), maybe there's just a problem in rendering them?
    morph "#volunteers", render(partial: "admin/volunteers/volunteers_table", locals: {pagy: pagy, volunteers: volunteers})
    morph "#paginator", render(partial: "admin/shared/paginator", locals: {pagy: pagy, filter: filter})
  end
end
