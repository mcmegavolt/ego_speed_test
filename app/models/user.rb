class User
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  field :login, type: String
  field :name, type: String
  has_many :records, dependent: :destroy
  has_many :comments
end
