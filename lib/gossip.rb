require "json"

class Gossip
  attr_reader :author, :content, :comments
  @@count = 0

  #constructeur.
  def initialize(author, content)
    @author = author
    @content = content
    @comments = []
  end

  #Permet de sauvergarder un gossip dans un fichier json.
  def save
    json = File.read("./db/gossip.json")
    array = JSON.parse(json)
    @@count = array.length + 1
    hash = { "author" => @author, "content" => @content, "id" => @@count }
    array.push(hash)
    File.open("./db/gossip.json", "w") do |f|
      f.puts JSON.pretty_generate(array)
    end
  end

  # Permet de changer le contenu d'un gossip existant.
  def self.update(id, author, content)
    json = File.read("./db/gossip.json")
    array = JSON.parse(json)
    el = array.map { |element|
      if element["id"] == id.to_i
        { "author" => author, "content" => content, "id" => id.to_i }
      else
        element
      end
    }
    File.open("./db/gossip.json", "w") do |f|
      f.puts JSON.pretty_generate(el)
    end
  end

  #Renvoie tous les gossips existants pour la page d'accueil. Renvoie une array contenant des instances de Gossip.
  def self.all
    json = File.read("./db/gossip.json")
    array = JSON.parse(json)
    gossips_array = array.map { |element| Gossip.new(element["author"], element["content"]) }
    gossips_array
  end

  #Permet de trouver un gossip particulier. Renvoie une instance de Gossip.
  def self.find(id)
    json = File.read("./db/gossip.json")
    array = JSON.parse(json)
    el = array.select { |element| element["id"] == id.to_i }
    return Gossip.new(el[0]["author"], el[0]["content"])
  end
end
