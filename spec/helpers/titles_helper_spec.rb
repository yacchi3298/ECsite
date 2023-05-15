require 'rails_helper'
require 'spree/testing_support/factories'
include ApplicationHelper


RSpec.describe ApplicationHelper, type: :helper do

  describe "#full_title" do
    context "productに値が入っている場合" do
      let(:product) { create(:product,name:"SOLIDUS GIRLY") }
      it 'show用タイトルが正常に表示される' do
        expect(helper.full_title(product.name)).to eq"#{product.name} - #{BASE_TITLE}"
      end
    end

    context "productに値が入っていない場合" do
      it "index用タイトルが正常に表示される" do
        expect(helper.full_title(nil)).to eq BASE_TITLE
      end
    end
  end
end
