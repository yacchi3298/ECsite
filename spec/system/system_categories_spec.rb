require 'rails_helper'

RSpec.describe "Categoriesページ", type: :system do
  describe "カテゴリー表示" do
    let(:taxonomy) { create(:taxonomy, name: "Category") }
    let!(:taxon) { create(:taxon, name: "shirts", parent: taxonomy.root) }
    let!(:taxon2) { create(:taxon, name: "hoodie", parent: taxonomy.root) }
    let(:product) { create(:product, name: "ruby polo", price: 15, taxons: [taxon]) }
    let(:image) { create(:image) }
    before do
      driven_by(:rack_test)
      product.images << image
      visit potepan_category_path(taxon.id)
    end

    it "カテゴリーページのパスが正しいこと" do
      expect(page).to have_current_path potepan_category_path(taxon.id)
    end

    it "カテゴリーページのタイトルが正常に表示できること" do
      expect(page).to have_title "shirts - BIGBAG Store"
    end

    it "商品が正常に表示されること" do
      expect(page).to have_content "ruby polo"
      expect(page).to have_content product.display_price.to_s
    end

    it "カテゴリーが正常に表示されること" do
      within ".side-nav" do
        click_on 'Category'
        expect(page).to have_content "shirts"
        expect(page).to have_content "Category"
      end
    end

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
