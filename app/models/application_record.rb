class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def date
    created_at.strftime("%B %d, %Y")
  end
end