class Api::V1::PostersController < ApplicationController

    def index
         #base query
         posters = Poster.all
         
        #sorting logic
        if params[:sort] == 'desc'
            sort_order = :desc 
        else
            sort_order = :asc 
        end

        #filtering logic
        if params[:name]
            posters = posters.where("lower(name) LIKE ?", "%#{params[:name].downcase}%").order(:name)
        end

        if params[:max_price]
            posters = posters.where("price <= ?", params[:max_price])
        end
        
        if params[:min_price]
            posters = posters.where("price >= ?", params[:min_price])
        end
        
        #apply sorting 
        posters = posters.order(created_at: sort_order)

        #format json response 
        render json: PosterSerializer.format_posters(posters)
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