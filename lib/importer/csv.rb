require "csv"

module Importer
  module Csv
    def self.import(path, model, extras)
      total = []

      CSV.open(path, "r", headers: :first_row).each do |row|
        total << model.new(extras ? row.to_h.merge(extras) : row.to_h).save
      end

      total
    end
  end
end
