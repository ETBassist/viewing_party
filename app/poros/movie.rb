class Movie
  attr_reader :title,
              :vote_average,
              :runtime,
              :description,
              :genres,
              :cast_members,
              :reviews_data,
              :reviews_count,
              :movie_id

  def initialize(movie_details, movie_credits, movie_reviews)
    @title = movie_details[:original_title]
    @vote_average = movie_details[:vote_average]
    @runtime = movie_details[:runtime]
    @description = movie_details[:overview]
    @genres = movie_details[:genres]
    @cast_members = movie_credits[:cast]
    @reviews_data = movie_reviews[:results]
    @reviews_count = movie_reviews[:total_results]
    @movie_id = movie_details[:id]
  end

  def top_ten_cast_members
    @cast_members[0..9].map do |member|
      CastMember.new(member)
    end
  end

  def formatted_runtime
    "#{@runtime/60}h #{@runtime % 60}min"
  end

  def genre_names
    @genres.map do |genre|
      genre[:name]
    end
  end

  def reviews
    @reviews_data.map do |rev|
      Review.new(rev)
    end
  end
end
