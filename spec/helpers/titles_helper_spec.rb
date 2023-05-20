require 'rails_helper'
require 'spree/testing_support/factories'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#full_title" do
    context "引数に文字列が与えられた場合" do
      it 'show用タイトルが正常に表示される' do
        expect(full_title("test")).to eq "test - BIGBAG Store"
      end
    end

    context "引数がnilの場合" do
      it "index用タイトルが正常に表示される" do
        expect(full_title(nil)).to eq "BIGBAG Store"
      end
    end

    context "引数が空白の場合" do
      it "index用タイトルが正常に表示される" do
        expect(full_title(" ")).to eq "BIGBAG Store"
      end
    end

    context "引数が空の場合" do
      it "index用タイトルが正常に表示される" do
        expect(full_title("")).to eq "BIGBAG Store"
      end
    end
  end
end
