require 'pry'
require 'csv'

class Gossip

  attr_accessor :content, :author

  def initialize(author, content)
    @content = content
    @author = author

  end

  def save

    CSV.open("db/gossip.csv", "ab") do |csv|
      csv << [author, content]
    end

  end

  def self.find(id)
    all_gossips = self.all
    puts all_gossips[id]
    return all_gossips[id]
  end

  def self.update(nb, gossip)
    gossip_newarray = CSV.read("db/gossip.csv")
    gossip_newarray[nb][0]=gossip.author
    gossip_newarray[nb][1]=gossip.content

    CSV.open("db/gossip.csv", 'w') do |csv_object|
      gossip_newarray.each do |row_array|
        csv_object << row_array
      end
    end

  end

  def self.all
    all_gossips=[]
    csv = CSV.read("db/gossip.csv")
    csv.each { |array2|
      all_gossips << Gossip.new(array2[0],array2[1])
    }
    return all_gossips

  end
end
#.pry
#my_gossip = Gossip.new("auteur3", "ceci est un exemple content3")
#my_gossip.save
#Gossip.update(1,my_gossip)
#puts "iciiii"
#Gossip.all
