module ApplicationHelper
  def comment_count_label(comments)
    if comments.count == 0
      "This recipe has no comments."
    elsif comments.count == 1
      "1 comment"
    else
      "#{comments.count} comments"
    end
  end
end