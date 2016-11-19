class Request < ApplicationRecord
  belongs_to :agent, class_name: 'User'

end