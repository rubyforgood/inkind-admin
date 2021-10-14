require "csv"

module Importer
  module Csv
    def self.import(path, model, additional_properties = {})
      total = []

      CSV.open(path, "r", headers: :first_row).each do |row|
        total << model.new(additional_properties ? row.to_h.merge(additional_properties) : row.to_h).save
      end

      total
    end
  end
end
