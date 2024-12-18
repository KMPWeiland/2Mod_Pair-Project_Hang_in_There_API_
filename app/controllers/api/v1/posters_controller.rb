class Api::V1::PostersController < ApplicationController

    def index
        render json: Poster.all
    end

    def show
        render json: Poster.find(params[:id])
    end

    def update
        poster = Poster.find(params[:id])
        if poster.update(poster_params)
            render json: poster
        else
            render json: "error"
    end

    private

    def poster_params
        params.require(:poster).permit(:name, :description, :price, :year, :vintage, :img_url)
    end

end