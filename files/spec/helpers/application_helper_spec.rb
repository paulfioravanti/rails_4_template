require 'spec_helper'

describe ApplicationHelper do
  describe "#full_title" do
    let(:base_title) { t('layouts.application.base_title') }

    context "with a page title" do
      it "displays the base and page title" do
        expect(full_title("foo")).to eql("#{base_title} | foo")
      end
    end

    context "without a page title" do
      it "displays only the base title" do
        expect(full_title("")).to eq(base_title)
      end
    end
  end
end