class Comment < ApplicationRecord
  # Validations
  validates_presence_of :content

  # Relationships
  belongs_to :post
  belongs_to :user
end
