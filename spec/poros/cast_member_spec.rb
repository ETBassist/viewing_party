require "rails_helper"

RSpec.describe CastMember do
  it "exists with attributes" do

    json_credits_response = File.read('spec/fixtures/poros/movies/fight_club_credits.json')
    credits = JSON.parse(json_credits_response, symbolize_names: true)

    cast_member = CastMember.new(credits[:cast][0])

    expect(cast_member.class).to eq(CastMember)
    expect(cast_member.actor).to eq("Edward Norton")
    expect(cast_member.character).to eq("The Narrator")
  end
end
