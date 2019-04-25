class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def date
    self.created_at.strftime("%B %d, %Y")
  end
end