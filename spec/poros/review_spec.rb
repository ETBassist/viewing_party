require "rails_helper"

RSpec.describe Review do
  it "exists with attributes" do

    json_reviews_response = File.read('spec/fixtures/poros/movies/fight_club_reviews.json')
    reviews = JSON.parse(json_reviews_response, symbolize_names: true)

    review = Review.new(reviews[:results][0])

    expect(review.author).to eq("Goddard")
    expect(review.description.class).to eq(String)
  end
end
