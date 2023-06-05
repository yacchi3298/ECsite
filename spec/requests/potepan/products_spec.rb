require 'rails_helper'

RSpec.describe "Potepan::Products", type: :request do
  describe "#show" do
    let(:taxon) { create(:taxon) }
    let(:product) { create(:product, taxons: [taxon]) }
    let!(:image) { create(:image) }
    let!(:related_products) { create_list(:product, 5, taxons: [taxon]) }

    before do
      product.images << image
      get potepan_product_path(product.id)
    end

    it "詳細ページを正常に取得できること" do
      expect(response).to have_http_status(200)
    end

    it "商品情報を正常に取得できること" do
      expect(response.body).to include product.name
      expect(response.body).to include product.display_price.to_s
      expect(response.body).to include product.description
    end

    it "関連商品を正常に取得できること" do
      expect(response.body).to include related_products[0].name
      expect(response.body).to include related_products[0].display_price.to_s
    end
  end
end
