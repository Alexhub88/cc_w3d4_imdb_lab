require_relative("./db/sql_runner")
require_relative("./movie")
require_relative("./casting")

class Star

  attr_reader :id
  attr_accessor :first_name, :last_name

  def initialize(new_star)
    @id = new_star['id'].to_i if new_star['id']
    @first_name = new_star['first_name']
    @last_name = new_star['last_name']
  end

  def save()
    sql = "INSERT INTO stars
    (first_name,last_name) VALUES ($1, $2)
    RETURNING id"
    values = [@first_name, @last_name]
    star = SqlRunner.run(sql, values).first
    @id = star['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM stars"
    values = []
    stars = SqlRunner.run(sql, values)
    result = stars.map { |star| Star.new(star) }
    return result
  end

  def update()
    sql = "UPDATE stars
    SET (first_name,last_name) = ($1, $2)
    WHERE id = $3"
    values = [@first_name, @last_name, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM stars"
    values = []
    SqlRunner.run(sql, values)
  end

  def self.map_items(stars_data)
    result = stars_data.map { |star| Star.new(star) }
    return result
  end

  def movies_featuring_this_star()
    sql = "SELECT movies.*
     FROM movies
     INNER JOIN castings
     ON castings.movie_id = movies.id
     WHERE star_id = $1"
     values = [@id]
     movies_data = SqlRunner.run(sql, values)
     return Movie.map_items(movies_data)
  end
end
