class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at

  attribute(:commenter) {|o| o.object.user.name }
end