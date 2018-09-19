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
end
