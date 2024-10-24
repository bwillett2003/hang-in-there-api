class Poster < ApplicationRecord
  validates :name, :description, :price, :year, :img_url, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :year, numericality: { only_integer: true }
  validates :vintage, inclusion: { in: [true, false] }

  def self.filter_by_params(params = {})
    posters = all
    posters = posters.order(created_at: (params[:sort] == "desc" ? :desc : :asc)) if params[:sort].present?
    posters
  end
end