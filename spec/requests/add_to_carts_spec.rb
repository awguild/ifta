require 'spec_helper'

describe "AddToCarts" do
  before { create_conference }

  describe "GET /add_to_carts" do
    it "adds to cart" do
      sign_in_as_a_valid_user
      follow_redirect!
      follow_redirect!
      expect(response.status).to eql(200)
    end
  end
end
