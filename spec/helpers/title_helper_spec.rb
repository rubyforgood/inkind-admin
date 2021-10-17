require "rails_helper"

RSpec.describe TitleHelper, type: :helper do
  describe "#page_title" do
    it "is the title content and the default title" do
      helper.content_for(:title) { "Users" }
      expect(helper.page_title).to eql "Users | INKIND"
    end

    it "is the default title when no title content exists" do
      expect(helper.page_title).to eql "INKIND"
    end
  end
end
