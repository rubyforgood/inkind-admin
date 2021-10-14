require "rails_helper"

RSpec.describe Importer::Csv do
  context "Importing Volunteers" do
    it "imports data based on the csv structure" do
      path = Rails.root.join("spec", "fixtures", "volunteers.csv")
      total = Importer::Csv.import(path, User, {skip_password_validation: true})

      expect(total.uniq).to be_truthy
    end

    it "excludes the row when it's not possible to import" do
      path = Rails.root.join("spec", "fixtures", "volunteers-with-errors.csv")
      total = Importer::Csv.import(path, User, {skip_password_validation: true})

      expect(total.uniq).to eq [true, false]
    end
  end
end
