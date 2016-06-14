require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = FactoryGirl.build(:user) }

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:auth_token) }
  it { should be_valid }

  # describe "when email is not present" do
  #   before { @user.email = " " }
  #   it { should_not be_valid }
  # end
  # Refactored:
  it { should validate_presence_of(:email) }

  # TODO
  # Obtain the precise manner to test this using after_action :create
  xit { should validate_uniqueness_of(:auth_token)}

  it { should have_many(:products) }

  describe "#generate_authentication_token!" do
    it "generates a unique token" do
      # Deprecated stub rspec-mocks syntax
      # Devise.stub(:friendly_token).and_return("auniquetoken123")
      allow(@user).to receive(:auth_token).and_return("auniquetoken123")
      @user.generate_authentication_token!
      expect(@user.auth_token).to eql "auniquetoken123"
    end

    it "generates another token when one already has been taken" do
      existing_user = FactoryGirl.create(:user, auth_token: "auniquetoken123")
      @user.generate_authentication_token!
      expect(@user.auth_token).not_to eql existing_user.auth_token
    end
  end

  describe "#products association" do
     before do
       @user.save
       3.times { FactoryGirl.create :product, user: @user }
     end

     it "destroys the associated products on self destruct" do
       products = @user.products
       @user.destroy
       products.each do |product|
         expect(Product.find_by(product)).to raise_error ActiveRecord::RecordNotFound
       end
     end
   end
end
