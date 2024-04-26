Rails.application.eager_load!
models = ActiveRecord::Base.descendants
models.each do |model|
  next unless model.table_exists?
  puts "Deleting data from from #{model.name}..."
  model.destroy_all
end

comment = [
  "I recommend this teapot for green tea.",
  "This teapot was made by a national treasure artisan.",
  "The way that the teapot changes color over time will make you fall in love with it.",
  "This teapot is ideal for serving tea to large groups of people.",
  "The flavor and aroma of tea will improve over time with this teapot.",
  "The creation of this kind of teapot gives each one a one-of-a-kind quality that is truly unique.",
  "If you enjoy black tea, I highly recommend this teapot.",
  "Bla bla bla something else about tea, bla bla bla.",
  "I'm out of ideas for writing stuff about tea, so I'm writing this.",
  "Who lives in a pineapple under the sea?"
]
kilntype = %w[Banko-yaki Tokoname-yaki Kutani-yaki Arita-yaki Hagi-yaki Mashiko-yaki Karatsu-yaki]
shape = %w[Yokode Uwade Ushirode Houbin Shiboridashi]
maker = ["Yuutarou Yamada", "Yoshiki Murata", "Fujita Tokuta", "Yutaka Tsuzuki", "Hiroshi Koie", "Koushi Umehara", "Junzo Maekawa", "Seiho Tsuzuki", "Murakoshi Fuugetsu"]


50.times do
  teapot = Teapot.new
  teapot.price = rand(30..5000)*100
  teapot.kilntype = kilntype[rand(7)]
  teapot.shape = shape[rand(5)]
  teapot.maker = maker[rand(9)]
  teapot.comment = comment[rand(10)]
  teapot.height = rand(70..160)/10.to_f
  teapot.width = rand(100..200)/10.to_f
  teapot.depth = rand(100..200)/10.to_f
  teapot.weight = rand(150..500)
  teapot.ccs = rand(150..600)
  teapot.in_stock = true
  teapot.views = rand(100)
  if teapot.save!
    puts "Teapot created"
  end
end
