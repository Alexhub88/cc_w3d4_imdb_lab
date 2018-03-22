require_relative( '../movie' )
require_relative( '../star' )
require_relative( '../casting' )

require( 'pry-byebug' )

Casting.delete_all()
Movie.delete_all()
Star.delete_all()

star1 = Star.new({ 'first_name' => 'Harrison', 'last_name' => 'Ford' })
star1.save()
star2 = Star.new({ 'first_name' => 'Ben', 'last_name' => 'Affleck' })
star2.save()
star3 = Star.new({ 'first_name' => 'Jennifer', 'last_name' => 'Garner' })
star3.save()

movie1 = Movie.new({ 'title' => 'Daredevil', 'genre' => 'Superhero', 'rating' => '6'})
movie1.save()
movie2 = Movie.new({ 'title' => 'Indiana Jones', 'genre' => 'Action', 'rating' => '8'})
movie2.save()

casting1 = Casting.new({ 'star_id' => star1.id, 'movie_id' => movie1.id, 'fee' => '55'})
casting1.save()
casting2 = Casting.new({ 'star_id' => star3.id, 'movie_id' => movie1.id, 'fee' => '34'})
casting2.save()
casting3 = Casting.new({ 'star_id' => star1.id, 'movie_id' => movie2.id, 'fee' => '22'})
casting3.save()
casting4 = Casting.new({ 'star_id' => star2.id, 'movie_id' => movie2.id, 'fee' => '66'})
casting4.save()

p Casting.all()
p Movie.all()
p Star.all()

p casting4.star()
p casting4.movie()

p star3

star3.last_name = 'Aniston'
star3.update()
p star3

p movie2

movie2.genre = 'Drama'
movie2.update()
p movie2

p casting1.star

casting1.star_id = star2.id
casting1.update()
p casting1.star

p movie2.stars_in_the_movie()

p star3.movies_featuring_this_star()

Casting.delete_all()
Movie.delete_all()
Star.delete_all()

p Casting.all()
p Movie.all()
p Star.all()

binding.pry
nil
