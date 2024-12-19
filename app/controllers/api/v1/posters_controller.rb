class Api::V1::PostersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def index
        render json: Poster.all
    end

    def show
        render json: Poster.find(params[:id])
    end

    def create
        poster = Poster.create(poster_params)
        render json: poster
    end

    def update
        # render json: Poster.update(params[:id], poster_params)
        poster = Poster.find(params[:id])
        if poster.update(poster_params)
            render json: poster
        else
            record_not_found(error)
        end
    end

    private

    def poster_params
        params.require(:poster).permit(:name, :description, :price, :year, :vintage, :img_url)
    end

    def record_not_found(error)
        render json: { error: "Poster not found" }, status: :not_found
    end

end