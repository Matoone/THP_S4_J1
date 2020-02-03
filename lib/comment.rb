require "gossip"

# création d'une classe qui hérite de comment par feignantise. Super appelle le constructeur parent.
class Comment < Gossip
  attr_reader :author, :content, :gossip_id

  def initialize(author, content, gossip_id)
    super(author, content)
    @gossip_id = gossip_id
  end

  #Save overwrite la méthode du parent.
  def save
    json = File.read("./db/comment.json")
    array = JSON.parse(json)
    hash = { "author" => @author, "content" => @content, "gossip_id" => @gossip_id.to_i }
    array.push(hash)
    File.open("./db/comment.json", "w") do |f|
      f.puts JSON.pretty_generate(array)
    end
  end

  # Renvoie una array contenant les instances de comment qui ont l'id de gossip_id.
  def self.all_by_gossip_id(gossip_id)
    json = File.read("./db/comment.json")
    array = JSON.parse(json)
    comments_array = array.select { |element| element["gossip_id"] == gossip_id.to_i }.map { |element| Comment.new(element["author"], element["content"], element["gossip_id"]) }
    comments_array
  end
end
