require('pg')
require_relative('../db/sql_runner')

class Artist

  attr_accessor :artist_name
  attr_reader :id

  def initialize(options)
    @artist_name = options['artist_name']
    @id = options['id'].to_i if options ['id']
  end

  def save()
    sql = "INSERT INTO artists (
    artist_name) VALUES ($1) RETURNING id"
    values = [@artist_name]
    artist = SqlRunner.run(sql, values)
    @id = artist[0]['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

#list all artists:
  def self.all()
    sql = "SELECT * FROM artists"
    result = SqlRunner.run(sql)
    return result.map {|artist_hash| Artist.new(artist_hash)}
  end

#we have the artist id, we want the albums
  def albums
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [@id] #meaning the ID of the artist
    artist_albums = SqlRunner.run(sql, values)
    return artist_albums.map{|album_hash| Album.new(album_hash)}
  end

  # def update_artist()
  #   sql = "UPDATE artists SET
  #   artist_name = $1
  #   WHERE id = $2"
  #   values = [@artist_name, @id]
  # end



##
end
