class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at

  belongs_to :recipe

  attribute(:commenter) {|o| o.object.user.name }
end