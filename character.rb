#!/usr/bin/ruby
require 'rubygems'
require 'sinatra'
require 'sqlite3'

db = SQLite3::Database.new("characters.db")

get "/character/:name/add_item/:item" do
    results = db.execute("insert into items (player, item) values (\"#{params['name']}\", \"#{params['item']}\");")
    "success"
end

get "/character/:name/delete_item/:id" do
    results = db.execute("delete from items where id=#{params['id']};")
    "success"
end

get "/character/:name/items" do
    results = db.execute("select *  from items where player = \"#{params['name']}\";")
    erb :items, :locals => { :items => results} 
end

get "/character/:name/hp_minus" do
    results = db.execute("select hp_cur from characters where name = \"#{params['name']}\";")[0]
    db.execute("update characters set hp_cur = #{results[0] - 1} where name = \"#{params['name']}\";")[0]
    results = db.execute("select hp_cur from characters where name = \"#{params['name']}\";")[0]
    "#{results}"
end

get "/character/:name/hp_plus" do
    results = db.execute("select hp_cur from characters where name = \"#{params['name']}\";")[0]
    db.execute("update characters set hp_cur = #{results[0] + 1} where name = \"#{params['name']}\";")[0]
    results = db.execute("select hp_cur from characters where name = \"#{params['name']}\";")[0]
    "#{results}"
end

get "/character/:name/hp_cur" do
    results = db.execute("select hp_cur from characters where name = \"#{params['name']}\";")[0]
    "#{results[0]}"
end

get "/character/:name" do
    results = db.execute("select hp_max,hp_cur from characters where name = \"#{params['name']}\";")[0]
    erb :character, :locals => { :name => params['name'], :hp_max => results[0] }

end


get "/characters" do
    results = db.execute("select name from characters;")
    erb :characters, :locals => { :characters => results} 
end

get "/" do
    results = db.execute("select name from characters;")
    erb :root, :locals => { :characters => results} 
end
