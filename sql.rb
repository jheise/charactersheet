#!/usr/bin/ruby
require "sqlite3"

db = SQLite3::Database.new("characters.db")

results = db.execute('select * from characters where name = "Rothar";')[0] 
results.each do |ret|
    puts "ret is #{ret}"
end
puts "results is #{results.class}"
