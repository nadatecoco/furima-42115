require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'アソシエーション' do
    it { should belong_to(:buyer) }
  end

  describe 'バリデーション' do
    it { should validate_presence_of(:postal_code) }
    it { should validate_presence_of(:prefecture_id) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:addresses) }
    it { should validate_presence_of(:phone_number) }
  end
end
