require 'bundler'
Bundler.require
require 'gossip'

class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end

  get '/gossips/:id/' do
    nb= params['id']
    nb = nb.to_i
    erb :gossips_print, locals: {gossip: Gossip.find(nb), nb: nb}
  end

  get '/gossips/:id/edit/' do
    nb= params['id']
    nb = nb.to_i
    erb :gossips_edit, locals: {nb: nb}
  end

  post '/gossips/:id/edit/' do
    puts "iciii"
    gossip_new = Gossip.new(params["gossip_author"], params["gossip_content"])
    puts "iciii22"
    nb= params['id'].to_i
    Gossip.update(nb,gossip_new)
    puts "modification termine"
    redirect '/'
  end

  #run! if app_file == $0
end
