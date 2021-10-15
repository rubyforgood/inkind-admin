module ExportToCsv
  extend ActiveSupport::Concern

  included do
    def self.export_to_csv(collection, columns: column_names, headers: columns)
      CSV.generate(headers: true, force_quotes: true) do |csv|
        csv << headers

        collection.each do |obj|
          csv << if obj.respond_to?(:to_csv)
            obj.to_csv
          else
            columns.map { |column| column.split(".").inject(obj, :try) }
          end
        end
      end
    end
  end
end
