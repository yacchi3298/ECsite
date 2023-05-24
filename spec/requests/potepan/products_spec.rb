require 'rails_helper'
require 'spree/testing_support/factories'

RSpec.describe "Potepan::Products", type: :request do
  describe "#show" do
    let(:product) { create(:product,taxons:[taxon]) }
    let(:image) { create(:image) }
    let(:taxon) { create(:taxon) }
    before do
      product.images << image
      get potepan_product_path(product.id)
    end

    it "詳細ページを正常に取得できること" do
      expect(response).to have_http_status(200)
    end

    it "商品名を正常に取得できること" do
      expect(response.body).to include product.name
    end

    it "商品の値段を正常に取得できること" do
      expect(response.body).to include product.display_price.to_s
    end

    it "商品名を正常に取得できること" do
      expect(response.body).to include product.description
    end
  end
end
