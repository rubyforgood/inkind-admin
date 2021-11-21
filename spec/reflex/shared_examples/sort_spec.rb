RSpec.shared_examples "sortable table" do |column, records, template|
  it "sorts #{column} in asc order" do
    reflex.element.dataset.column = column
    reflex.element.dataset.direction = "asc"

    reflex.run(:sort)

    morph = reflex.broadcaster.morphs.first
    expect(morph.first).to eql "#sortable"
    expect(morph.second).to eql ApplicationController.render(template,
      layout: false,
      locals: {records: records.order(column => :asc)})
  end

  it "sorts #{column} in desc order" do
    reflex.element.dataset.column = column
    reflex.element.dataset.direction = "desc"

    reflex.run(:sort)

    morph = reflex.broadcaster.morphs.first
    expect(morph.first).to eql "#sortable"
    expect(morph.second).to eql ApplicationController.render(template,
      layout: false,
      locals: {records: records.order(column => :desc)})
  end
end
