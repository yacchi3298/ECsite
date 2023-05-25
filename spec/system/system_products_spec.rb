require 'rails_helper'

RSpec.describe "SystemProducts", type: :system do
  describe "products表示" do
    let!(:taxon) { create(:taxon) }
    let(:product) { create(:product, name: "ruby polo", price: 15, taxons: [taxon]) }
    let(:image) { create(:image) }
    before do
      driven_by(:rack_test)
      product.images << image
      visit potepan_product_path(product.id)
    end

    it "商品詳細ページのパスが正しいこと" do
      expect(page).to have_current_path potepan_product_path(product.id)
    end

    it "商品詳細ページのタイトルを確認" do
      expect(page).to have_title "ruby polo - BIGBAG Store"
    end

    it "商品が正常に表示されること" do
      expect(page).to have_content "ruby polo"
      expect(page).to have_content product.display_price.to_s
    end

    it "一覧ページへ戻るリンククリックでカテゴリーページに遷移できること" do
      click_on '一覧ページへ戻る'
      expect(page).to have_current_path potepan_category_path(taxon.id)
    end
  end
end
