class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body

  attribute(:commenter) {|o| o.object.user.name }
end