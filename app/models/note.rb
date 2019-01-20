class Note < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, uniqueness: true
  validates_length_of :title, maximum: 300, allow_blank: false

  validates :body, presence: true
end
