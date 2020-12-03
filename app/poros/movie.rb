class Movie
  attr_reader :title,
              :vote_average,
              :runtime,
              :description,
              :genres,
              :cast_members,
              :reviews

  def initialize(movie_details, movie_credits, movie_reviews)
    @title = movie_details[:original_title]
    @vote_average = movie_details[:vote_average]
    @runtime = movie_details[:runtime]
    @description =  movie_details[:overview]
    @genres = movie_details[:genres]
    @cast_members = movie_credits[:cast]
    @reviews = movie_reviews[:results]
  end

  def reviews_count
    @reviews[:total_results]
  end

  def top_ten_cast_members
    @cast_members[0..9]
  end

  def genre_names
    @genres.map do |genre|
      genre[:name]
    end
  end
end
