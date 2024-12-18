require 'rails_helper'

describe "Posters API", type: :request do
  it 'fetches posters' do
Poster.destroy_all

regret = Poster.create!(
    name: "REGRET",
    description: "Hard work rarely pays off.",
    price: 89.00,
    year: 2018,
    vintage: true,
    img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d"
)

failure = Poster.create!(
    name: "FAILURE",
    description: "Why bother trying? It's probably not worth it.",
    price: 68.00,
    year: 2019,
    vintage: true,
    img_url: "https://images.unsplash.com/photo-1620401537439-98e94c004b0d"
)

mediocrity = Poster.create!(
    name: "MEDIOCRITY",
    description: "Dreams are just that—dreams.",
    price: 127.00,
    year: 2021,
    vintage: false,
    img_url: "https://images.unsplash.com/photo-1551993005-75c4131b6bd8"
)
    
  it 'fetches all posters' do
    Poster.destroy_all

    @regret = Poster.create!(name: "REGRET",
      description: "Hard work rarely pays off.",
      price: 89.00,
      year: 2018,
      vintage: true,
      img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d"
    )

    @failure = Poster.create!(name: "FAILURE",
      description: "Why bother trying? It's probably not worth it.",
      price: 68.00,
      year: 2019,
      vintage: true,
      img_url: "https://images.unsplash.com/photo-1620401537439-98e94c004b0d"
    )

    @mediocrity = Poster.create!(name: "MEDIOCRITY",
      description: "Dreams are just that—dreams.",
      price: 127.00,
      year: 2021,
      vintage: false,
      img_url: "https://images.unsplash.com/photo-1551993005-75c4131b6bd8"
    )


    get '/api/v1/posters'

    expect(response).to be_successful
    posters = JSON.parse(response.body, symbolize_names: true)
    expect(posters.count).to eq(3)

    posters.each do |poster|
    expect(poster).to have_key(:id)
    expect(poster[:id]).to be_an(Integer)
    expect(poster).to have_key(:id)
    expect(poster[:id]).to be_an(Integer)

     expect(poster).to have_key(:name)
     expect(poster[:name]).to be_a(String)
        
     expect(poster).to have_key(:description)
     expect(poster[:description]).to be_a(String)
        
     expect(poster).to have_key(:price)
     expect(poster[:price]).to be_a(Float)
        
     expect(poster).to have_key(:year)
     expect(poster[:year]).to be_a(Integer)

     expect(poster).to have_key(:img_url)
     expect(poster[:img_url]).to be_a(String)

    expect(poster).to have_key(:name)
    expect(poster[:name]).to be_a(String)
    expect(poster).to have_key(:description)
    expect(poster[:description]).to be_a(String)
    expect(poster).to have_key(:price)
    expect(poster[:price]).to be_a(Float)
    expect(poster).to have_key(:year)
    expect(poster[:year]).to be_a(Integer)
    expect(poster).to have_key(:img_url)
    expect(poster[:img_url]).to be_a(String)
    end
  end


  it "can get one poster by its id" do
    #setup
    id = Poster.create!(name: "REGRET",
    description: "Hard work rarely pays off.",
    price: 89.00,
    year: 2018,
    vintage: true,
    img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d").id

    #make a GET request to fetch the poster by ID
    get "/api/v1/posters/#{id}"
  
    #parse the JSON response
    # require "pry"; binding.pry
    poster = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
  
    expect(poster).to have_key(:name)
    expect(poster[:name]).to be_a(String)

    expect(poster).to have_key(:description)
    expect(poster[:description]).to be_a(String)

    expect(poster).to have_key(:price)
    expect(poster[:price]).to be_a(Float)

    expect(poster).to have_key(:year)
    expect(poster[:year]).to be_a(Integer)

    expect(poster).to have_key(:img_url)
    expect(poster[:img_url]).to be_a(String)
  end


  it 'creates a new poster' do

        new_poster = {
            name: "REGRET",
            description: "Hard work rarely pays off.",
            price: 89.00,
            year: 2018,
            vintage: true,
            img_url: "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d"
        }

        post '/api/v1/posters#create', params: { poster: new_poster }

        poster = JSON.parse(response.body, symbolize_names: true)

        expect(poster[:name]).to eq(new_poster[:name])
        expect(poster[:description]).to eq(new_poster[:description])
        expect(poster[:price]).to eq(new_poster[:price])
        expect(poster[:year]).to eq(new_poster[:year])
        expect(poster[:img_url]).to eq(new_poster[:img_url])
    end
end