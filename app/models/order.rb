class Order < ApplicationRecord
  include AASM

  validates :name, :order_number, :state, presence: true
  validates :state, inclusion: {in: ['pending', 'in_progress', 'finished']}
  validates :order_number, uniqueness: true

  aasm column: 'state' do
    state :pending, initial: true
    state :in_progress
    state :finished

    event :finish do
      transitions from: [:in_progress], to: :finished
    end

    event :do do
      transitions from: [:pending], to: :in_progress
    end
  end

  def state_badge
    if pending?
      'badge-info'
    elsif in_progress?
      'badge-warning'
    elsif finished?
      'badge-success'
    end
  end

  def destroy
    errors.add(:base, 'não foi possível excluir o pedido') && return if !pending?
    super
  end
end
