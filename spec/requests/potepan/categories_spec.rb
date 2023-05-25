require 'rails_helper'

RSpec.describe "Potepan::Categories", type: :request do
  describe "GET /show" do
    let(:taxonomy) { create(:taxonomy) }
    let!(:taxon1) { create(:taxon, name: "shirts", parent: taxonomy.root) }
    let!(:taxon2) { create(:taxon, name: "hoodie", parent: taxonomy.root) }
    let(:product1) { create(:product,name: "ruby polo",taxons:[taxon1]) }
    let(:product2) { create(:product,name: "solidus girly",price: 12,taxons:[taxon2]) }
    let(:image) { create(:image) }
    before do
      product1.images << image
      get potepan_category_path(taxon1.id)
    end

    it "Categoriesページを正常に取得できること" do
      expect(response).to have_http_status(200)
    end

    it "商品を正常に取得できること" do
      expect(response.body).to include product1.name
      expect(response.body).to include product1.display_price.to_s
      expect(response.body).not_to include product2.name
      expect(response.body).not_to include product2.display_price.to_s
    end

    it "カテゴリーリストを正常に取得できること" do
      expect(response.body).to include taxonomy.name
      expect(response.body).to include taxon1.name
      expect(response.body).to include taxon2.name
    end
  end
end
