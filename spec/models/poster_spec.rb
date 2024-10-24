require 'rails_helper'

RSpec.describe Poster, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:year) }
    it { should validate_presence_of(:img_url) }
    it { should validate_numericality_of(:price).is_greater_than(0) }
    it { should validate_numericality_of(:year).only_integer }
    it { should validate_inclusion_of(:vintage).in_array([true, false]) }
  end
end