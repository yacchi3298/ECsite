require 'rails_helper'

RSpec.describe Potepan::ProductDecorator, type: :model do
  describe "relation_products" do
    let(:taxon1)             { create(:taxon) }
    let(:taxon2)             { create(:taxon) }
    let(:taxon3)             { create(:taxon) }
    let(:unrelated_product)  { create(:product, taxons: [taxon3]) }
    let(:product)           { create(:product, taxons: [taxon1, taxon2]) }
    let!(:related_products) { create_list(:product, 5, taxons: [taxon1, taxon2]) }

    it "relation_productsで関連商品を正常に取得できること" do
      expect(product.relation_products).to be_truthy
      expect(product.relation_products).to include related_products[0]
    end

    it "unrelated_productが関連商品に含まれないこと" do
      expect(product.relation_products).not_to include unrelated_product
    end

    it "メインの商品が含まれないこと" do
      expect(product.relation_products).not_to include product
    end

    it "関連商品に重複がないこと" do
      expect(product.relation_products).to eq related_products.uniq.first(4)
    end

    it "5つ目の関連商品は表示されないこと" do
      expect(product.relation_products).not_to include related_products[5]
    end
  end
end
