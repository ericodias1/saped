class Order < ApplicationRecord
  validates :name, :order_number, :state, presence: true
  validates :order_number, uniqueness: true
end
