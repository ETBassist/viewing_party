class MoviesFacade
  def self.movie(id)
    movie_json = MovieService.movie(id)
    Movie.new(movie_json)
  end

  def self.top_rated_movies
    MovieService.top_rated_movies.map do |movie_data|
      Movie.new(movie_data)
    end
  end

  def self.movies_by_keyword(name)
    MovieService.movies_by_keyword(name).map do |movie_data|
      Movie.new(movie_data)
    end
  end
end
