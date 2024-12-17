require 'rails_helper'

describe "Posters API", type: :request do
    it 'fetches posters' do

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

    

    # posters.each do |poster|


    end
end