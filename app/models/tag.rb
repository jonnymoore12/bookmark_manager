class Tag
  include DataMapper::Resource

  property :id,  Serial
  property :name,  String

  #has n, :taggings
  has n, :links, through: Resource # => :taggings
end
