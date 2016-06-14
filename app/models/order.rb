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
end
