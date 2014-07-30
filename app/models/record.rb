class Record
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  field :title, type: String
  field :body, type: String
  has_many :comments, dependent: :destroy
  belongs_to :user
end
