require "rails_helper"

RSpec.describe "API Posters Endpoints" do
  before(:each) do
    @poster_1 = Poster.create(
      name: "REGRET",
      description: "Hard work rarely pays off.",
      price: 89.00,
      year: 2018,
      vintage: true,
      img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d"
    )

    @poster_2 = Poster.create(
      name: "DEFEAT",
      description: "It's too late to start now.",
      price: 35.00,
      year: 2023,
      vintage: false,
      img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d"
    )

    @poster_3 = Poster.create(
      name: "DESPAIR",
      description: "Let someone else do it; youll just mess it up.",
      price: 73.00,
      year: 2015,
      vintage: false,
      img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d"
    )
  end

  it "gets all posters" do
    get "/api/v1/posters" 

    expect(response).to be_successful

    posters = JSON.parse(response.body, symbolize_names: true)

    expect(posters[:data].count).to eq(3)

    posters[:data].each do |poster|
      expect(poster).to have_key(:id)
      expect(poster[:id]).to be_an(String)
      expect(poster[:type]).to be_an(String)
      expect(poster[:attributes][:name]).to be_a(String)
      expect(poster[:attributes][:description]).to be_a(String)
      expect(poster[:attributes][:price]).to be_a(Float)
      expect(poster[:attributes][:year]).to be_a(Integer)
      expect(poster[:attributes][:vintage]).to eq(true).or eq(false)
      expect(poster[:attributes][:img_url]).to be_a(String)
  end
end

  it "can get one poster" do
    get "/api/v1/posters/#{@poster_1.id}"

    expect(response).to be_successful

    poster = JSON.parse(response.body, symbolize_names: true)

    expect(poster[:data]).to have_key(:id)
    expect(poster[:data][:id]).to be_an(String)
    expect(poster[:data][:type]).to be_an(String)
    expect(poster[:data][:attributes][:name]).to be_a(String)
    expect(poster[:data][:attributes][:description]).to be_a(String)
    expect(poster[:data][:attributes][:price]).to be_a(Float)
    expect(poster[:data][:attributes][:year]).to be_a(Integer)
    expect(poster[:data][:attributes][:vintage]).to eq(true).or eq(false)
    expect(poster[:data][:attributes][:img_url]).to be_a(String)
  end

  it "creates a poster" do
    post "/api/v1/posters", params: @poster_1.to_json, headers: { "CONTENT_TYPE" => "application/json" }
  
    expect(response). to be_successful
  
    poster = JSON.parse(response.body, symbolize_names: true)
  
    expect(poster[:data][:attributes][:name]).to eq(@poster_1[:name])
    expect(poster[:data][:attributes][:description]).to eq(@poster_1[:description])
    expect(poster[:data][:attributes][:price]).to eq(@poster_1[:price])
    expect(poster[:data][:attributes][:year]).to eq(@poster_1[:year])
    expect(poster[:data][:attributes][:vintage]).to eq(@poster_1[:vintage])
    expect(poster[:data][:attributes][:img_url]).to eq(@poster_1[:img_url])
  end

  it "can update an existing poster" do
    previous_name = @poster_1.name
    poster_params = { name: "FAILURE" }

    patch "/api/v1/posters/#{@poster_1.id}", params: poster_params.to_json, headers: { "CONTENT_TYPE" => "application/json" }

    expect(poster[:data][:attributes][:name]).to_not eq(previous_name)
    expect(poster[:data][:attributes][:name]).to eq("FAILURE")
  end
end