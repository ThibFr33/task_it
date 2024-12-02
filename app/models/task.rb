class Task < ApplicationRecord
  belongs_to :list

  validates :label, presence: true
end
