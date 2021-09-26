require "rails_helper"

RSpec.describe CepSchema do
  def normalize_json(string)
    JSON.pretty_generate JSON.parse(string)
  end

  it "matches the dumped schema (rails graphql:schema:dump)" do
    aggregate_failures do
      expect(normalize_json(described_class.to_json)).to eq(
        normalize_json(
          File.read(Rails.root.join("export/graphql/schema.json"))
        )
      )
    end
  end
end
