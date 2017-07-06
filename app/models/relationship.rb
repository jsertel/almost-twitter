class Relationship < ApplicationRecord
  belongs_to :username
  belongs_to :friend, class_name: 'User'

  
end
