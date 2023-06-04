require 'rails_helper'

RSpec.describe Potepan::Product_Decorator, type: :model do
  describe "relation_products" do
    let(:taxon)             { create(:taxon) }
    let(:product)           { create(:product, taxons: [taxon]) }
    let!(:related_products) { create_list(:product, 5, taxons: [taxon]) }

    it "relation_productsで関連商品を正常に取得できること" do
      expect(product.relation_products).to be_truthy
      expect(product.relation_products).to include related_products[0]
    end

    it "メインの商品が含まれないこと" do
      expect(product.relation_products).not_to include product
    end

    it "関連商品に重複がないこと" do
      expect(related_products == relation_products.distinct).to be_truthy
    end

    it "関連商品が4件取得される" do
    end
  end
end
