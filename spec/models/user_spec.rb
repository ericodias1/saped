require 'rails_helper'

RSpec.describe User, type: :model do
  describe do
    fixtures :users

    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }

    it { should validate_uniqueness_of(:email).case_insensitive }

  end
end
