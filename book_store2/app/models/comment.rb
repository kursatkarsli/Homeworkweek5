class Comment < ApplicationRecord
  belongs_to :book
  belongs_to :user
  scope :approved, -> {where(accept: true)}
end
