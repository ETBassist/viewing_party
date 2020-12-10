class MovieService
  def self.top_rated_movies(num_pages = 2)
    movies = []
    num_pages.times do |num|
      movies << get_json("/3/movie/top_rated?page=#{num + 1}")[:results]
    end
    movies.flatten
  end

  def self.movies_by_keyword(name, num_pages = 2)
    movies = []
    num_pages.times do |num|
      movies << get_json("/3/search/movie?query=#{name}&page=#{num + 1}")[:results]
    end
    movies.flatten.compact
  end

  def self.movie(id)
    get_json("/3/movie/#{id}?append_to_response=credits,reviews")
  end

  def self.conn
    Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
      faraday.params['api_key'] = ENV['MOVIE_DB_API_KEY']
    end
  end

  def self.get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
