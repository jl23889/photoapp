class Album
  include Mongoid::Document
  field :name

  validates_presence_of :name

  belongs_to :user
  has_and_belongs_to_many :photos

  index({ name: 1 }, { unique: true })
end
