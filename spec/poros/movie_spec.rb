require "rails_helper"

RSpec.describe Movie do
  it "exists with attributes", :vcr do
    json_details_response = File.read('spec/fixtures/poros/movies/fight_club_details.json')

    details = JSON.parse(json_details_response, symbolize_names: true)

    movie = Movie.new(details)

    expect(movie.title).to eq("Fight Club")
    expect(movie.vote_average).to eq(8.4)
    expect(movie.runtime).to eq(139)
    expect(movie.genres).to eq([{:id=>18, :name=>"Drama"}])
    expect(movie.genre_names).to eq(["Drama"])
    expect(movie.description.class).to eq(String)
    expect(movie.cast_members.class).to eq(Array)
    expect(movie.formatted_runtime).to eq("2h 19min")
    expect(movie.reviews_data.class).to eq(Array)
  end
end
