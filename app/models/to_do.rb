class ToDo < ApplicationRecord
  validates :title, :body, presence: true
end