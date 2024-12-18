class Api::V1::PostersController < ApplicationController

    def index
        render json: Poster.all
    end

    def show
        poster = Poster.find(params[:id])
        render json: poster
    end

    
    def create
        poster = Poster.create(poster_params)
        render json: poster
    end

    def update
        render json: Postere.update(params[:id], poster_params)    
        render json: Poster.find(params[:id])
    end

    def destroy
        render json: Poster.delete(params[:id])
    end

    private

    def poster_params
        params.require(:poster).permit(:name, :description, :price, :year, :vintage, :img_url)
    end
end