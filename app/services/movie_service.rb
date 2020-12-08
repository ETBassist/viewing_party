class MovieService
  def self.top_rated_movies
    movies = get_json('/3/movie/top_rated?page=1')[:results]
    movies << get_json('/3/movie/top_rated?page=2')[:results]
    movies.flatten
  end

  def self.movies_by_keyword(name)
    response = get_json("/3/search/movie?query=#{name}")
    movies = response[:results]
    movies << get_json("/3/search/movie?query=#{name}&page=2")[:results] if response[:total_pages] > 1
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
