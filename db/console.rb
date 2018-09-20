require("pry")
require_relative("../models/artist")
require_relative("../models/album")

Album.delete_all()
Artist.delete_all()


artist1 = Artist.new({
  "artist_name" => "Aretha Franklin"})

artist2 = Artist.new({"artist_name" => "Stevie Wonder"})

artist1.save()
artist2.save()

album1 = Album.new({"album_name" => "Lady Soul", "artist_id" => artist1.id, "genre" => "soul"})
#the artist id is taken from other database
#can call .id as we have attr_reader

album2 = Album.new({"album_name" => "Young, Gifted and Black", "artist_id" => artist1.id, "genre" => "R&B"})

album3 = Album.new({"album_name" => "For Once in my Life", "artist_id" => artist2.id, "genre" => "R&B"})

album1.save()
album2.save()
album3.save()

Artist.all()

Album.all()

#We have the artist, what are their albums?
artist1.albums

album3.artist

album1.genre = "R&B" #could this just work because of the attr_accessor?
album1.update_album() #not working in pry

binding.pry
nil
