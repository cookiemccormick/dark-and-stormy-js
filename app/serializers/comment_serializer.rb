class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :recipe_id, :user_id

  belongs_to :recipe
end