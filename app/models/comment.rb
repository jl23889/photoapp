class Comment
  include Mongoid::Document
  field :name
  field :content
  embedded_in :photo, inverse_of: :comments
end
