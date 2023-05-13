require 'rails_helper'
require 'spree/testing_support/factories'

RSpec.describe "Potepan::Products Systems", type: :system do
  before do
    driven_by(:rack_test)
  end

  pending "add some scenarios (or delete) #{__FILE__}"
end
