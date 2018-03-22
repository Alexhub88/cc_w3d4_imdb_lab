require_relative("./db/sql_runner")
require_relative("./movie")
require_relative("./star")

class Casting

  attr_reader :id
  attr_accessor :movie_id, :star_id, :fee

  def initialize(new_casting)
    @id = new_casting['id'].to_i if new_casting['id']
    @movie_id = new_casting['movie_id'].to_i
    @star_id = new_casting['star_id'].to_i
    @fee = new_casting['fee'].to_i
  end

  def save()
    sql = "INSERT INTO castings
    (movie_id, star_id, fee)
    VALUES
    ($1, $2, $3)
    RETURNING id"
    values = [@movie_id, @star_id, @fee]
    casting = SqlRunner.run(sql,values).first
    @id = casting['id'].to_i
  end

  def star()
    sql = "SELECT * FROM stars WHERE id = $1"
    values = [@star_id]
    star = SqlRunner.run(sql, values).first
    return Star.new(star)
  end

  def movie()
    sql = "SELECT * FROM movies WHERE id = $1"
    values = [@movie_id]
    movie = SqlRunner.run(sql, values).first
    return Movie.new(movie)
  end

  def self.all()
    sql = "SELECT * FROM castings"
    casting_data = SqlRunner.run(sql)
    return Casting.map_items(casting_data)
  end

  def self.delete_all()
   sql = "DELETE FROM castings"
   SqlRunner.run(sql)
  end

  def self.map_items(casting_data)
    result = casting_data.map { |casting| Casting.new(casting) }
    return result
  end

  def update()
    sql = "UPDATE castings
    SET (movie_id, star_id, fee) = ($1, $2, $3)
    WHERE id = $4"
    values = [@movie_id, @star_id, @fee, @id]
    SqlRunner.run(sql, values)
  end

end
