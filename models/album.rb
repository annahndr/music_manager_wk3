require("pg")
require_relative("../db/sql_runner")

class Album()

  attr_accessor :album_name, :artist_id
  attr_reader :id

  def initialize(options)
    @album_name = options["album_name"]
    @id = options["id"].to_i if options["id"]
    @artist_id = options["artist_id"].to_i
  end

  def save()
    sql = "INSERT INTO albums (album_name, artist_id) VALUES ($1, $2) RETURNING id"
    values = [@album_name, @artist_id]
    album = SqlRunner.run(sql, values)
    @id = album[0]['id'].to_i
  end


end
