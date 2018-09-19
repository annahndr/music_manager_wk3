require('pry')
require_relative('../models/artist')

Artist.delete_all()

artist1 = Artist.new({
  "artist_name" => "Aretha Franklin"})

artist1.save()


a

binding.pry
nil
