class Api::V1::PostersController < ApplicationController
  def index
    posters = Poster.all
    render json: PosterSerializer.new(posters)
  end







  

 


end












def create
  poster = Poster.find(poster_params)
  render json: PosterSerializer.new(posters)
end