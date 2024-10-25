class Poster < ApplicationRecord
  validates :name, :description, :price, :year, :img_url, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :year, numericality: { only_integer: true }
  validates :vintage, inclusion: { in: [true, false] }

  def self.apply_params(params = {})
    posters = all
    posters = posters.order(created_at: (params[:sort] == "desc" ? :desc : :asc)) if params[:sort].present?
    posters = posters.where('name ILIKE ?', "%#{params[:name]}%") if params[:name].present?
    posters = posters.where( "price <= ?", params[:max_price]) if params[:max_price].present?
    posters = posters.where( "price >= ?", params[:min_price]) if params[:min_price].present?
    posters
  end
end



