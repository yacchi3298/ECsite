require 'rails_helper'

RSpec.describe "SystemProducts", type: :system do
  let!(:taxon) { create(:taxon) }
  let!(:taxon2) { create(:taxon) }
  let!(:product) { create(:product, name: "ruby polo", price: 15, taxons: [taxon]) }
  let!(:related_products)  { create_list(:product, 5, taxons: [taxon]) }
  let!(:related_products2) { create(:product, taxons: [taxon2]) }
  let!(:image) { create(:image) }

  before do
    product.images << image
    visit potepan_product_path(product.id)
  end

  describe "productsページの表示について" do
    it "商品詳細ページのパスが正しいこと" do
      expect(page).to have_current_path potepan_product_path(product.id)
    end

    it "商品詳細ページのタイトルが正しいこと" do
      expect(page).to have_title "ruby polo - BIGBAG Store"
    end

    it "商品が正常に表示されること" do
      expect(page).to have_content "ruby polo"
      expect(page).to have_content product.display_price
    end

    it "関連商品が表示される" do
      within ".productsContent" do
        expect(page).to have_content related_products[0].name
        expect(page).to have_content related_products[0].display_price
      end
    end

    it "関連しない商品は表示されない" do
      within ".productsContent" do
        expect(page).not_to have_content related_products2.name
      end
    end

    it "関連商品が4件表示される" do
      within ".productsContent" do
        expect(page).to have_selector ".productBox", count: 4
      end
    end
  end

  describe "リンクの動作について" do
    it "一覧ページへ戻るリンククリックでカテゴリーページに遷移できること" do
      click_on '一覧ページへ戻る'
      expect(page).to have_current_path potepan_category_path(taxon.id)
    end

    it "関連商品をクリックすると商品詳細ページへ遷移する" do
      click_on related_products[0].name
      expect(page).to have_current_path potepan_product_path(related_products[0].id)
    end
  end
end
