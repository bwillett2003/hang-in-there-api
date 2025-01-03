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
    it { should allow_value(true).for(:vintage) }
    it { should allow_value(false).for(:vintage) }
  end

  describe "The apply_params Class Method" do
    before(:each) do
      Poster.destroy_all
  
      @poster_1 = Poster.create(
        name: "REGRET",
        description: "Hard work rarely pays off.",
        price: 89.00,
        year: 2018,
        vintage: true,
        img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d",
        created_at: 2.days.ago
      )
  
      @poster_2 = Poster.create(
        name: "DEFEAT",
        description: "It's too late to start now.",
        price: 35.00,
        year: 2023,
        vintage: false,
        img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d",
        created_at: 1.day.ago
      )
  
      @poster_3 = Poster.create(
        name: "DESPAIR",
        description: "Let someone else do it; youll just mess it up.",
        price: 73.00,
        year: 2015,
        vintage: false,
        img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d",
        created_at: Time.now
      )
    end
    
    it "returns posters sorted by ascending order" do
      result = Poster.apply_params(sort: 'asc')
      expect(result).to eq([@poster_1, @poster_2, @poster_3])
    end
    
    it "returns posters sorted by descending order" do
      result = Poster.apply_params(sort: 'desc')
      expect(result).to eq([@poster_3, @poster_2, @poster_1])
    end
    
    it "returns posters filter by name (case-insenstitive and partial names)" do
      result_1 = Poster.apply_params(name: 'gReT')
      expect(result_1).to include(@poster_1)
      expect(result_1).not_to include(@poster_2, @poster_3)
      
      result_2 = Poster.apply_params(name: 'dE')
      expect(result_2).to include(@poster_2, @poster_3)
      expect(result_2).not_to include(@poster_1)
    end

    it 'returns posters with price greater than or equal to min_price' do
      result = Poster.apply_params(min_price: 50)
      expect(result).to eq([@poster_1, @poster_3])
    end
  
    it 'returns posters with price less than or equal to max_price' do
      result = Poster.apply_params(max_price: 50)
      expect(result).to eq([@poster_2])
    end
  end
end