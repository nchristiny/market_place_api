class Order < ActiveRecord::Base
  before_validation :set_total!

  # Not needed due to #set_total! method
  # validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :user_id, presence: true

  belongs_to :user
  has_many :placements
  has_many :products, through: :placements

  def set_total!
    self.total = products.map(&:price).sum
  end

  def build_placements_with_product_ids_and_quantities(product_ids_and_quantities)
    product_ids_and_quantities.each do |product_id_and_quantity|
      id, quantity = product_id_and_quantity
      self.placements.build(product_id: id, quantity: quantity)
    end
  end
end
