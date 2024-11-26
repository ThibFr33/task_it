class List < ApplicationRecord
  enum category: { autre: 0, courses: 1, vacances: 2, maison: 3, administratif: 4, enfatns: 5 }

  belongs_to :user
  has_many :tasks
end
