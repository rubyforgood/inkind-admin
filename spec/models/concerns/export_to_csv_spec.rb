require "rails_helper"

describe ExportToCsv do
  let(:fake_identity) { Struct.new(:first_name, :last_name) }
  let(:fake_person) do
    Struct.new(:id, :identity, :age, :country) do
      include ExportToCsv

      def self.column_names
        %w[id age country]
      end
    end
  end

  let(:collection) { double(:batch) }

  context "when to_csv method is not defined" do
    let(:felipe) { fake_person.new(1, fake_identity.new("Felipe", "Casadei"), 32, "United States") }
    let(:rodolfo) { fake_person.new(2, fake_identity.new("Rodolfo", "Santos"), 31, "Brazil") }
    let(:collection) { [felipe, rodolfo] }

    it "exports a csv using default column names" do
      expect(fake_person.export_to_csv(collection)).to eq <<~CSV
        "id","age","country"
        "1","32","United States"
        "2","31","Brazil"
      CSV
    end

    it "exports a csv using custom headers" do
      headers = ["number", "age", "country name"]
      expect(fake_person.export_to_csv(collection, headers: headers)).to eq <<~CSV
        "number","age","country name"
        "1","32","United States"
        "2","31","Brazil"
      CSV
    end

    it "supports nested columns" do
      headers = ["number", "first name", "second name", "age", "country"]
      columns = %w[id identity.first_name identity.last_name age country]

      expect(fake_person.export_to_csv(collection, headers: headers, columns: columns)).to eq <<~CSV
        "number","first name","second name","age","country"
        "1","Felipe","Casadei","32","United States"
        "2","Rodolfo","Santos","31","Brazil"
      CSV
    end

    it "supports null safe nested columns" do
      headers = %w[id middle_name]
      columns = %w[id identity.middle.name]

      expect(fake_person.export_to_csv(collection, headers: headers, columns: columns)).to eq <<~CSV
        "id","middle_name"
        "1",""
        "2",""
      CSV
    end
  end

  context "when to_csv method is available" do
    it "supports custom formatting when #to_csv method is available" do
      felipe = double(:felipe)
      rodolfo = double(:rodolfo)

      expect(felipe).to receive(:to_csv).and_return([1, "Felipe Casadei", 32, "United States"])
      expect(rodolfo).to receive(:to_csv).and_return([2, "Rodolfo Santos", 31, "Brazil"])

      collection = [felipe, rodolfo]

      headers = ["id", "full name", "age", "country"]
      expect(fake_person.export_to_csv(collection, headers: headers)).to eq <<~CSV
        "id","full name","age","country"
        "1","Felipe Casadei","32","United States"
        "2","Rodolfo Santos","31","Brazil"
      CSV
    end
  end
end
