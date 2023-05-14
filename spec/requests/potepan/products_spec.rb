require 'rails_helper'
require 'spree/testing_support/factories'

RSpec.describe "Potepan::Products", type: :request do
  describe "#show" do
    let!(:product) { create(:product) }
    let!(:image) { create(:image) }
    before do
      product.images << image
      get potepan_product_path(product.id)
      # 画像URLの取得が上手くいかない問題への対応
      # https://mng-camp.potepan.com/curriculums/document-for-final-task-2#notes-of-image-test
      ActiveStorage::Current.host = request.base_url
      product.reload
      image.reload
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
