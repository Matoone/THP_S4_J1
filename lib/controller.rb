class ApplicationController < Sinatra::Base
  get "/gossips/new/" do
    erb :new_gossip
  end
  get "/" do
    erb :index, locals: { gossips: Gossip.all }
  end

  post "/gossips/new/" do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect "/"
  end

  get "/gossips/:id" do
    erb :show, locals: { gossip: Gossip.find(params["id"]), id: params["id"], comments: Comment.all_by_gossip_id(params["id"]) }
    # "<html><head><title>Gossip</title></head><body><h1>Auteur:  #{Gossip.find(params["id"]).author} Content: #{Gossip.find(params["id"]).content}</body></html>"
  end

  get "/gossips/:id/edit/" do
    erb :edit, locals: { gossip: Gossip.find(params["id"]), id: params["id"] }
  end

  post "/gossips/:id/update/" do
    Gossip.update(params["id"], params["gossip_author"], params["gossip_content"])
    redirect "/"
  end
  get "/gossips/:id/comment/" do
    erb :new_comment, locals: { gossip: Gossip.find(params["id"]), id: params["id"] }
  end
  post "/gossips/:id/new_comment/" do
    Comment.new(params["comment_author"], params["comment_content"], params["id"]).save
    redirect "/"
  end
end
