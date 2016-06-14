require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do
  describe "GET #show" do
    before(:each) do
      @product = FactoryGirl.create :product
      get :show, id: @product.id
    end

    it "returns the information about a reporter on a hash" do
      product_response = json_response
      expect(product_response[:title]).to eql @product.title
    end

    it { should respond_with 200 }
  end

  describe "GET #index" do
    number_of_products = 2 + rand(8)
    before(:each) do
      number_of_products.times { FactoryGirl.create :product }
      get :index
    end

    it "returns all (#{number_of_products}) records from the database" do
      products_response = json_response
    expect(products_response[:products].count).to be(number_of_products)
  end

    it { should respond_with 200 }
  end
end
