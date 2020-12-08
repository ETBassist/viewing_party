class MovieService
  def self.conn
    Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
      faraday.params['api_key'] = ENV['MOVIE_DB_API_KEY']
    end
  end

  def self.get_json(url)
    response = self.conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  # def self.top_rated_movies
  #   movies = get_json('/3/movie/top_rated?page=1')[:results]
  #   movies << get_json('/3/movie/top_rated?page=2')[:results]
  # end

  def self.movie(id)
    get_json("/3/movie/#{id}?append_to_response=credits,reviews")
  end
end
