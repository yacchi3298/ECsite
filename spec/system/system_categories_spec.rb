require 'rails_helper'

RSpec.describe "Categoriesページ", type: :system do
  let(:taxonomy) { create(:taxonomy, name: "Category") }
  let!(:taxon) { create(:taxon, name: "shirts", parent: taxonomy.root) }
  let!(:taxon2) { create(:taxon, name: "hoodie", parent: taxonomy.root) }
  let(:product) { create(:product, name: "ruby polo", price: 15, taxons: [taxon]) }
  let(:product2) { create(:product, name: "solidus girly", price: 12, taxons: [taxon2]) }
  let(:image) { create(:image) }
  before do
    driven_by(:rack_test)
    product.images << image
    visit potepan_category_path(taxon.id)
  end

  describe "カテゴリーページの表示について" do
    it "カテゴリーページのパスが正しいこと" do
      expect(page).to have_current_path potepan_category_path(taxon.id)
    end

    it "カテゴリーページのタイトルが正常に表示できること" do
      expect(page).to have_title "shirts - BIGBAG Store"
    end

    it "商品が正常に表示されること" do
      expect(page).to have_content "ruby polo"
      expect(page).to have_content product.display_price.to_s
      expect(page).not_to have_content "solidus girly"
      expect(page).not_to have_content product2.display_price.to_s
    end

    it "サイドバーのカテゴリーが正常に表示されること" do
      within ".side-nav" do
        click_on 'Category'
        expect(page).to have_content "shirts"
        expect(page).to have_content "Category"
        expect(page).to have_content taxon.all_products.count
      end
    end

    it "ページに表示される商品数がカテゴリーリストの商品数と一致すること" do
      expect(page.all('.productBox').count).to eq taxon.all_products.count
    end
  end

  describe "リンクの動作について" do
    it "header_light_section HOMEリンククリックでトップページに正常に遷移できること" do
      within ".lightSection_home" do
        click_on 'HOME'
        expect(page).to have_current_path potepan_index_path
      end
    end

    it "header_logoクリックでトップページに正常に遷移できること" do
      within ".navbar-header" do
        click_on 'header_logo'
        expect(page).to have_current_path potepan_index_path
      end
    end

    it "header HOMEリンククリックでトップページに正常に遷移できること" do
      within ".navbar-right" do
        click_on 'Home'
        expect(page).to have_current_path potepan_index_path
      end
    end

    it "カテゴリーリンククリックでカテゴリーページに正常に遷移できること" do
      within ".side-nav" do
        click_on 'hoodie', match: :first
        expect(page).to have_current_path potepan_category_path(taxon2.id)
      end
    end
  end
end
