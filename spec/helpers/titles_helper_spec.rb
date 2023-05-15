require 'rails_helper'
require 'spree/testing_support/factories'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#full_title" do
    context "productに値が入っている場合" do
      let(:product) { create(:product, name: "SOLIDUS GIRLY") }
      it 'show用タイトルが正常に表示される' do
        expect(helper.full_title(product.name)).to eq "#{product.name} - BIGBAG Store"
      end
    end

    context "productに値が入っていない場合" do
      it "index用タイトルが正常に表示される" do
        expect(helper.full_title(nil)).to eq "BIGBAG Store"
      end
    end
  end
end
