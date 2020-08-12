require 'rails_helper'

RSpec.describe Order, type: :model do
  describe do
    fixtures :orders

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:order_number) }
    it { should validate_presence_of(:state) }

    it { should validate_uniqueness_of(:order_number) }

    it { should validate_inclusion_of(:state).
                  in_array(['pending', 'in_progress', 'finished'])}

  end

  describe 'test badge state' do
    it { expect(subject.state_badge).to eq('badge-info') }

    it do
      subject.update state: 'in_progress'
      expect(subject.state_badge).to eq('badge-warning')
    end

    it do
      subject.update state: 'finished'
      expect(subject.state_badge).to eq('badge-success')
    end
  end

  describe 'destroy only pending orders' do
    it do
      subject.update state: 'in_progress'
      expect(subject.destroy).to be_falsey
    end

    it do
      subject.update state: 'pending'
      expect(subject.destroy).to be_truthy
    end
  end
end
