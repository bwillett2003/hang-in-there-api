class Poster < ApplicationRecord
  validates :name, :description, :price, :year, :img_url, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :year, numericality: { only_integer: true }
  validates :vintage, inclusion: { in: [true, false] }
end
  
