require 'rails_helper'

RSpec.describe Buyer, type: :model do
  describe 'アソシエーション' do
    it { should belong_to(:user) }
    it { should belong_to(:item) }
    it { should have_one(:address) }
  end
end
