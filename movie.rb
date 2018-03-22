require_relative("./db/sql_runner")
require_relative("./star")
require_relative("./casting")

class Movie

  attr_reader :id
  attr_accessor :title, :genre, :rating

  def initialize(new_movie)
    @id = new_movie['id'].to_i if new_movie['id']
    @title = new_movie['title']
    @genre = new_movie['genre']
    @rating = new_movie['rating'].to_i
  end

  def save()
    sql = "INSERT INTO movies
    (title, genre, rating) VALUES ($1, $2, $3)
    RETURNING id"
    values = [@title, @genre, @rating]
    movie = SqlRunner.run(sql, values).first
    @id = movie['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM movies"
    values = []
    movies = SqlRunner.run(sql, values)
    result = movies.map { |movie| Movie.new(movie) }
    return result
  end

  def update()
    sql = "UPDATE movies
    SET (title, genre, rating) = ($1, $2, $3)
    WHERE id = $4"
    values = [@title, @genre, @rating, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM movies"
    values = []
    SqlRunner.run(sql, values)
  end

  def self.map_items(movies_data)
    result = movies_data.map { |movie| Movie.new(movie) }
    return result
  end

  def stars_in_the_movie()
    sql = "SELECT stars.*
     FROM stars
     INNER JOIN castings
     ON castings.star_id = stars.id
     WHERE movie_id = $1"
     values = [@id]
     stars_data = SqlRunner.run(sql, values)
     return Star.map_items(stars_data)
  end

end
