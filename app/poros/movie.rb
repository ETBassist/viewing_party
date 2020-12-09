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

  def initialize(movie_details)
    @title = movie_details[:original_title]
    @vote_average = movie_details[:vote_average]
    @runtime = movie_details[:runtime]
    @description = movie_details[:overview]
    @genres = movie_details[:genres]
    @cast_members = movie_details[:credits][:cast] if movie_details[:credits]
    @reviews_data = movie_details[:reviews][:results] if movie_details[:reviews]
    @reviews_count = movie_details[:reviews][:total_results] if movie_details[:reviews] # Take out
    @movie_id = movie_details[:id]
  end

  def formatted_runtime
    "#{@runtime / 60}h #{@runtime % 60}min"
  end

  def genre_names
    @genres.map do |genre|
      genre[:name]
    end
  end

  # Move to facade?
  def reviews
    @reviews_data.map do |rev|
      Review.new(rev)
    end
  end
end
