class Post < ApplicationRecord
  # Validations
  validates_presence_of :content

  # Relationships
  belongs_to :user
  has_many :comments
end
