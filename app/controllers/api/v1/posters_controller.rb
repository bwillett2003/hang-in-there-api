class Api::V1::PostersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  
  def index
    posters = Poster.apply_params(
      sort: params[:sort],
      name: params[:name],
      min_price: params[:min_price],
      max_price: params[:max_price]
    )
    render json: PosterSerializer.new(posters, { meta: { count: posters.size}})
  end

  def show
    poster = Poster.find(params[:id])
    render json: PosterSerializer.new(poster)
  end

  def create
    poster = Poster.create(poster_params)
    render json: PosterSerializer.new(poster)
  end

  def update
    poster = Poster.find(params[:id])
    poster.update(poster_params)

    render json: PosterSerializer.new(poster)
  end

  def destroy
    render json: Poster.delete(params[:id])
    head :no_content
  end

  private

  def render_not_found
    render json: { error: 'Poster not found' }, status: :not_found
  end
  
  def poster_params
    params.require(:poster).permit(:name, :description, :price, :year, :vintage, :img_url)
  end
end