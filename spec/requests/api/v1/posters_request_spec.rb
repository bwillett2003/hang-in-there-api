require "rails_helper"

RSpec.describe "API Posters Endpoints" do
  before(:each) do
    Poster.destroy_all

    @poster_1 = Poster.create(
      name: "REGRET",
      description: "Hard work rarely pays off.",
      price: 89.00,
      year: 2018,
      vintage: true,
      img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d",
      created_at: 2.days.ago
    )

    @poster_2 = Poster.create(
      name: "DEFEAT",
      description: "It's too late to start now.",
      price: 35.00,
      year: 2023,
      vintage: false,
      img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d",
      created_at: 1.day.ago
    )

    @poster_3 = Poster.create(
      name: "DESPAIR",
      description: "Let someone else do it; youll just mess it up.",
      price: 73.00,
      year: 2015,
      vintage: false,
      img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d",
      created_at: Time.now
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

    expect(response).to be_successful

    poster = JSON.parse(response.body, symbolize_names: true)

    expect(poster[:data][:attributes][:name]).to_not eq(previous_name)
    expect(poster[:data][:attributes][:name]).to eq("FAILURE")
  end

  it "destroys a poster" do
    get "/api/v1/posters"
  
    initial_count = JSON.parse(response.body, symbolize_names: true)[:data].count
    delete "/api/v1/posters/#{@poster_1.id}", headers: { "CONTENT_TYPE" => "application/json" }
  
    expect(response).to have_http_status(:no_content)
  
    get "/api/v1/posters"
    
    final_count = JSON.parse(response.body, symbolize_names: true)[:data].count
    expect(final_count).to eq(initial_count - 1)
  end

  it "has a JSON respons with a 'meta' count" do

      @posters = [@poster_1, @poster_2, @poster_3]

      get "/api/v1/posters"

      expect(response). to have_http_status(:ok)
      json = JSON.parse(response.body)

      expect(json['data'].size).to eq(@posters.size) 
      expect(json['meta']).to eq({'count' => @posters.size }) 
  end

  it "returns an empty array and count of zero when no posters exist" do
    Poster.destroy_all
  
    get "/api/v1/posters"
  
    json = JSON.parse(response.body)
  
    expect(json['data']).to be_empty
    expect(json['meta']).to eq({ 'count' => 0 })
  end

  it "can return posters sorted in ascending order by their created_at attribute" do

    get "/api/v1/posters?sort=asc"

    expect(response).to be_successful

    posters = JSON.parse(response.body, symbolize_names: true)[:data]
    
    expect(posters[0][:id].to_i).to eq(@poster_1.id)
    expect(posters[1][:id].to_i).to eq(@poster_2.id)
    expect(posters[2][:id].to_i).to eq(@poster_3.id)
  end

  it "can return posters sorted in descending order by their 'created_at' attribute" do

    get "/api/v1/posters?sort=desc"

    expect(response).to be_successful

    posters = JSON.parse(response.body, symbolize_names: true)[:data]
    
    expect(posters[0][:id].to_i).to eq(@poster_3.id)
    expect(posters[1][:id].to_i).to eq(@poster_2.id)
    expect(posters[2][:id].to_i).to eq(@poster_1.id)
  end

  it "can return posters with a partial name match" do
    get "/api/v1/posters?name=dE"

    expect(response).to be_successful

    posters = JSON.parse(response.body, symbolize_names:true)[:data]

    expect(posters.count).to eq(2)
    expect(posters[0][:attributes][:name]).to eq("DEFEAT")
  	expect(posters[1][:attributes][:name]).to eq("DESPAIR")
  end

describe "error handling" do
  it "returns a 404 not found error" do
    get "/api/v1/posters/99999"
    expect(response).to have_http_status(:not_found)

    json = JSON.parse(response.body)
    expect(json['errors'].first["status"].to eq("404"))
    expect(json['errors'].first["message"].to eq("Record not found"))
    end
  end
end