#Models - ruby class, inherit from ActiveRecord::Base class, create methods, data attributes, domain logic
#ActiveRecord Models - comprises methods for helping build your rails app
#ex. custom scopes, model instance methods, default settings for database columns, validations, model-to-model relationships, callbacks, custom algorithms

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  #base class only, specifies that this class cannot be instantiated directly

  def date
    created_at.strftime("%B %d, %Y")
  end
end