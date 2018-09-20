require('pg')
require_relative('../db/sql_runner')

class Album

  attr_accessor :artist_id, :album_name, :genre
  attr_reader :id

  def initialize(options)
    @album_name = options["album_name"]
    @id = options["id"].to_i if options["id"]
    @artist_id = options["artist_id"].to_i
    @genre = options["genre"]
  end

  def save()
    sql = "INSERT INTO albums (album_name, artist_id, genre) VALUES ($1, $2, $3) RETURNING id"
    values = [@album_name, @artist_id, @genre]
    album = SqlRunner.run(sql, values)
    @id = album[0]['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM albums"
    result = SqlRunner.run(sql)
    return result.map {|album_hash| Album.new(album_hash)}
  end

#bring back the artist if you know the album
  def artist()
   sql = "SELECT * FROM artists WHERE id = $1"
   #id refers to the id field in the artists table
   values = [@artist_id] #refers to the artist_id field in the albums table
   artist = SqlRunner.run(sql, values)
   return Artist.new(artist[0])

 end

 def update_album()
     sql = "UPDATE albums SET
     (album_name,
       artist_id,
       genre) =
     ($1, $2, $3)
     WHERE id = $4"
     values = [@album_name, @artist_id, @genre, @id]
    SqlRunner.run(sql, values)
     # return Album.new(album[0])

   end

end
