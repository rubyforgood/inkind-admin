RSpec.shared_examples "sortable table" do |column, records, template|
  let(:session) { double(dig: {}, load!: true) }

  before do
    allow_any_instance_of(ActionDispatch::Request)
      .to(receive(:session).and_return(session))
  end

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

RSpec.shared_examples "filterable table" do |column, value, filters, records, template, query|
  let(:session) { double(dig: {}, load!: true) }

  before do
    allow(session).to receive(:[]).with(:filters).and_return({volunteers_table: filters})
    allow_any_instance_of(ActionDispatch::Request)
      .to(receive(:session).and_return(session))
  end

  it "filter #{column}" do
    reflex.element.dataset.column = column
    reflex.element.value = value

    reflex.run(:filter)

    morph = reflex.broadcaster.morphs.first
    expect(morph.first).to eql "#sortable"
    expect(morph.second).to eql ApplicationController.render(template,
      layout: false,
      locals: {records: records.where(query)})
  end
end
