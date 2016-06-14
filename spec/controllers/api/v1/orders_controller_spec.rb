require 'rails_helper'

RSpec.describe Api::V1::OrdersController, type: :controller do
  describe "GET #index" do
    number_of_orders = 2 + rand(8)
    before(:each) do
      current_user = FactoryGirl.create :user
      api_authorization_header current_user.auth_token
      number_of_orders.times { FactoryGirl.create :order, user: current_user }
      get :index, user_id: current_user.id
    end

    it "returns 4 order records from the user" do
      orders_response = json_response[:orders]
      expect(orders_response.count).to eq(number_of_orders)
    end

    it { should respond_with 200 }
  end
end
