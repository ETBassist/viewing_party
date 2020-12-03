class CastMember
  attr_reader :actor,
              :character

  def initialize(details)
    @actor = details[:name]
    @character = details[:character]
  end
end
