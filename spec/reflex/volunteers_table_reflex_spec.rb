# frozen_string_literal: true

require "rails_helper"

RSpec.describe VolunteersTableReflex, type: :reflex do
  let(:reflex) { build_reflex(url: admin_volunteers_path) }

  describe "#sort" do
    before do
      2.times do
        create(:volunteer, status: :active)
        create(:volunteer, status: :inactive)
      end
    end

    context "status" do
      it "sort asc on status" do
        reflex.element.dataset.column = "status"
        reflex.element.dataset.direction = "asc"

        reflex.run(:sort)

        morph = reflex.broadcaster.morphs.first
        expect(morph.first).to eql "#sortable"
        expect(morph.second).to eql Admin::VolunteersController.render(:_volunteers_table,
          layout: false,
          locals: {records: User.all.order(status: :asc)})
      end

      it "sorts desc on status" do
        reflex.element.dataset.column = "status"
        reflex.element.dataset.direction = "desc"

        reflex.run(:sort)

        morph = reflex.broadcaster.morphs.first
        expect(morph.first).to eql "#sortable"
        expect(morph.second).to eql Admin::VolunteersController.render(:_volunteers_table,
          layout: false,
          locals: {records: User.all.order(status: :desc)})
      end
    end
  end
end
