class Api::V1::PostersController < ApplicationController

    def index
        # render json: Poster.all
        if params[:sort] == 'desc'
            sort_order = :desc 
        else
            sort_order = :asc 
        end
        
        posters = Poster.order(created_at: sort_order)
        render json: PosterSerializer.format_posters(posters)
        #do conditional checking to see if the param exist via query params = application/biz logic
        #after verifying that this key exists, then what has to be achieved to that data should be 
        #abstracted to the model 


    end

    def show
        # render json: Poster.find(params[:id])
        render json: PosterSerializer.format_single_poster(Poster.find(params[:id]))
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
            render json: { error: "poster not found" }, status: :not_found
            record_not_found(error)
        end
    end

    def destroy
        render json: Poster.delete(params[:id])
    end


    private

    def poster_params
        params.require(:poster).permit(:name, :description, :price, :year, :vintage, :img_url)
    end



end