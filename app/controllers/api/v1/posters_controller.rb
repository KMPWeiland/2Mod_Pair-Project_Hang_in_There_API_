class Api::V1::PostersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity_response
  

    def index
        #base query
        posters = Poster.all
        #filtering logic
        if params[:name].present?
            posters = posters.where("lower(name) LIKE ?", "%#{params[:name].downcase}%").order(:name)
        end

        if params[:max_price].present?
            posters = posters.where("price <= ?", params[:max_price])
        end
        
        if params[:min_price].present?
            posters = posters.where("price >= ?", params[:min_price])
        end
        
        #sorting logic
        if params[:sort] == 'asc'
            sort_asc = posters.order(:created_at)
            render json: PosterSerializer.format_posters(sort_asc)
        elsif params[:sort] == 'desc'
            sort_desc = posters.order(created_at: :desc) 
            render json: PosterSerializer.format_posters(sort_desc)
        else
            render json: PosterSerializer.format_posters(posters)
        end
    end

    def show
        poster = Poster.find(params[:id])
        if poster
            render json: PosterSerializer.format_single_poster(poster)
        else
            render json: {error: "Poster not found" }, status: :not_found
        end
    end

    def create
        poster = Poster.new(poster_params)
        if poster.save
            render json: PosterSerializer.format_single_poster(poster), status: :created
        else
            render json: { 
                errors: error_messages(poster.errors)
            },  
            status: :unprocessable_entity
        end
    end

    def update
        poster = Poster.find_by(id: params[:id])
        if poster.nil?
            render json: { errors: [{ status: "404", message: "Poster not found" }] }, status: :not_found
        elsif params[:poster][:name].blank?
            render json: { 
                errors: [{ status: "422", message: "Name cannot be blank." }]
            }, status: :unprocessable_entity
        elsif poster.update(poster_params)
            render json: PosterSerializer.format_single_poster(poster), status: :ok
        else
            render json: { 
                errors: error_messages(poster.errors)
            }, status: :unprocessable_entity
        end
    end

    def destroy
        poster = Poster.find(params[:id])
        if poster.nil?
            render json: { errors: [{ message: "Poster not found", status: "404" }] }, status: :not_found
        else
            poster.destroy
            head :no_content
        end
    end


    private

    def poster_params
        params.require(:poster).permit(:name, :description, :price, :year, :vintage, :img_url)
    end

    def not_found_response
        render json: { errors: [{ status: '404', message: 'Poster not found'}] }, status: :not_found
    end
    
    def error_messages(errors)
        errors.full_messages.map do |message|
            {
            status: '422',
            message: message
            }
        end
    end
    
    def unprocessable_entity_response(exception)
        render json: { 
            errors: error_messages(exception.record.errors) 
            }, status: :unprocessable_entity
    end
end