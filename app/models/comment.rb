class Comment
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  recursively_embeds_many
  field :body, type: String
  belongs_to :user
  belongs_to :record
end
